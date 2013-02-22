// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library http_server;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:uri';
import 'test_suite.dart';  // For TestUtils.
// TODO(efortuna): Rewrite to not use the args library and simply take an
// expected number of arguments, so test.dart doesn't rely on the args library?
// See discussion on https://codereview.chromium.org/11931025/.
import 'vendored_pkg/args/args.dart';
import 'utils.dart';


/// Interface of the HTTP server:
///
/// /echo: This will stream the data received in the request stream back 
///        to the client.
/// /root_dart/X: This will serve the corresponding file from the dart
///               directory (i.e. '$DartDirectory/X').
/// /root_build/X: This will serve the corresponding file from the build
///                directory (i.e. '$BuildDirectory/X').
/// /FOO/packages/BAR: This will serve the corresponding file from the packages
///                    directory (i.e. '$BuildDirectory/packages/BAR')
///
/// In case a path does not refer to a file but rather to a directory, a
/// directory listing will be displayed.

const PREFIX_BUILDDIR = 'root_build';
const PREFIX_DARTDIR = 'root_dart';

// TODO(kustermann,ricow): We could change this to the following scheme:
// http://host:port/root_packages/X -> $BuildDir/packages/X
// Issue: 8368


main() {
  /** Convenience method for local testing. */
  var parser = new ArgParser();
  parser.addOption('port', abbr: 'p',
      help: 'The main server port we wish to respond to requests.',
      defaultsTo: '0');
  parser.addOption('crossOriginPort', abbr: 'c',
      help: 'A different port that accepts request from the main server port.',
      defaultsTo: '0');
  parser.addOption('mode', abbr: 'm', help: 'Testing mode.',
      defaultsTo: 'release');
  parser.addOption('arch', abbr: 'a', help: 'Testing architecture.',
      defaultsTo: 'ia32');
  parser.addFlag('help', abbr: 'h', negatable: false,
      help: 'Print this usage information.');
  parser.addOption('package-root', help: 'The package root to use.');
  parser.addOption('network', help: 'The network interface to use.',
      defaultsTo: '127.0.0.1');
  var args = parser.parse(new Options().arguments);
  if (args['help']) {
    print(parser.getUsage());
  } else {
    // Pretend we're running test.dart so that TestUtils doesn't get confused
    // about the "current directory." This is only used if we're trying to run
    // this file independently for local testing.
    TestUtils.testScriptPath = new Path(new Options().script)
        .directoryPath
        .join(new Path('../../test.dart'))
        .canonicalize()
        .toNativePath();
    // Note: args['package-root'] is always the build directory. We have the
    // implicit assumption that it contains the 'packages' subdirectory.
    // TODO: We should probably rename 'package-root' to 'build-directory'.
    TestingServerRunner._packageRootDir = new Path(args['package-root']);
    TestingServerRunner._buildDirectory = new Path(args['package-root']);
    var network = args['network'];
    TestingServerRunner.startHttpServer(network,
        port: int.parse(args['port']));
    print('Server listening on port '
          '${TestingServerRunner.serverList[0].port}.');
    TestingServerRunner.startHttpServer(network,
        allowedPort: TestingServerRunner.serverList[0].port, port:
        int.parse(args['crossOriginPort']));
    print(
        'Server listening on port ${TestingServerRunner.serverList[1].port}.');
  }
}
/**
 * Runs a set of servers that are initialized specifically for the needs of our
 * test framework, such as dealing with package-root.
 */
class TestingServerRunner {
  static List serverList = [];
  static Path _packageRootDir = null;
  static Path _buildDirectory = null;

  // Added as a getter so that the function will be called again each time the
  // default request handler closure is executed.
  static Path get packageRootDir => _packageRootDir;
  static Path get buildDirectory => _buildDirectory;

  static setPackageRootDir(Map configuration) {
    _packageRootDir = TestUtils.absolutePath(
        new Path(TestUtils.buildDir(configuration)));
  }

  static setBuildDir(Map configuration) {
    _buildDirectory = TestUtils.absolutePath(
        new Path(TestUtils.buildDir(configuration)));
  }

  static startHttpServer(String host, {int allowedPort:-1, int port: 0}) {
    var httpServer = new HttpServer();
    httpServer.onError = (e) {
      DebugLogger.error('HttpServer: an error occured: $e');
    };
    httpServer.defaultRequestHandler = (request, response) {
      handleFileOrDirectoryRequest(request, response, allowedPort);
    };
    httpServer.addRequestHandler(
        (req) => req.path == "/echo", handleEchoRequest);

    httpServer.listen(host, port);
    serverList.add(httpServer);
  }


  static void handleFileOrDirectoryRequest(HttpRequest request,
                                           HttpResponse response,
                                           int allowedPort) {
    var path = getFilePathFromRequestPath(request.path);
    if (path != null) {
      var file = new File.fromPath(path);
      file.exists().then((exists) {
        if (exists) {
          sendFileContent(request, response, allowedPort, path, file);
        } else {
          var directory = new Directory.fromPath(path);
          directory.exists().then((exists) {
            if (exists) {
              listDirectory(directory).then((entries) {
                sendDirectoryListing(entries, request, response);
              });
            } else {
              sendNotFound(request, response);
            }
          });
        }
      });
    } else {
      if (request.path == '/') {
        var entries = [new _Entry('root_dart', 'root_dart/'),
                       new _Entry('root_build', 'root_build/'),
                       new _Entry('echo', 'echo')];
        sendDirectoryListing(entries, request, response);
      } else {
        sendNotFound(request, response);
      }
    }
  }

  static void handleEchoRequest(HttpRequest request, HttpResponse response) {
    response.headers.set("Access-Control-Allow-Origin", "*");
    request.inputStream.pipe(response.outputStream);
  }

  static Path getFilePathFromRequestPath(String urlRequestPath) {
    // Go to the top of the file to see an explanation of the URL path scheme.
    var requestPath = new Path(urlRequestPath.substring(1)).canonicalize();
    var pathSegments = requestPath.segments();
    if (pathSegments.length > 0) {
      var basePath;
      var relativePath;
      if (pathSegments[0] == PREFIX_BUILDDIR) {
        basePath = _buildDirectory;
        relativePath = new Path(
            pathSegments.getRange(1, pathSegments.length - 1).join('/'));
      } else if (pathSegments[0] == PREFIX_DARTDIR) {
        basePath = TestUtils.dartDir();
        relativePath = new Path(
            pathSegments.getRange(1, pathSegments.length - 1).join('/'));
      }
      var packagesDirName = 'packages';
      var packagesIndex = pathSegments.indexOf(packagesDirName);
      if (packagesIndex != -1) {
        var start = packagesIndex + 1;
        var length = pathSegments.length - start;
        basePath = _packageRootDir.append(packagesDirName);
        relativePath = new Path(
            pathSegments.getRange(start, length).join('/'));
      }
      if (basePath != null && relativePath != null) {
        return basePath.join(relativePath);
      }
    }
    return null;
  }

  static Future<List<_Entry>> listDirectory(Directory directory) {
    var completer = new Completer();
    var entries = [];

    directory.list()
      ..onFile = (filepath) {
        var filename = new Path(filepath).filename;
        entries.add(new _Entry(filename, filename));
      }
      ..onDir = (dirpath) {
        var filename = new Path(dirpath).filename;
        entries.add(new _Entry(filename, '$filename/'));
      }
      ..onDone = (_) {
        completer.complete(entries);
      };
    return completer.future;
  }

  /**
   * Sends a simple listing of all the files and sub-directories within
   * directory.
   *
   * This is intended to make it easier to browse tests when manually running
   * tests against this test server.
   */
  static void sendDirectoryListing(entries,
                                   HttpRequest request,
                                   HttpResponse response) {
    response.headers.set('Content-Type', 'text/html');
    var header = '''<!DOCTYPE html>
    <html>
    <head>
      <title>${request.path}</title>
    </head>
    <body>
      <code>
        <div>${request.path}</div>
        <hr/>
        <ul>''';
    var footer = '''
        </ul>
      </code>
    </body>
    </html>''';


    entries.sort();
    response.outputStream.writeString(header);
    for (var entry in entries) {
      response.outputStream.writeString(
          '<li><a href="${new Path(request.path).append(entry.name)}">'
          '${entry.displayName}</a></li>');
    }
    response.outputStream.writeString(footer);
    response.outputStream.close();
  }

  static void sendFileContent(HttpRequest request,
                              HttpResponse response,
                              int allowedPort,
                              Path path,
                              File file) {
    if (allowedPort != -1) {
      var origin = new Uri(request.headers.value('Origin'));
      // Allow loading from http://*:$allowedPort in browsers.
      var allowedOrigin =
          '${origin.scheme}://${origin.domain}:${allowedPort}';
      response.headers.set("Access-Control-Allow-Origin", allowedOrigin);
      response.headers.set('Access-Control-Allow-Credentials', 'true');
    } else {
      // No allowedPort specified. Allow from anywhere (but cross-origin
      // requests *with credentials* will fail because you can't use "*").
      response.headers.set("Access-Control-Allow-Origin", "*");
    }
    if (path.filename.endsWith('.html')) {
      response.headers.set('Content-Type', 'text/html');
    } else if (path.filename.endsWith('.js')) {
      response.headers.set('Content-Type', 'application/javascript');
    } else if (path.filename.endsWith('.dart')) {
      response.headers.set('Content-Type', 'application/dart');
    }
    file.openInputStream().pipe(response.outputStream);
  }

  static void sendNotFound(HttpRequest request, HttpResponse response) {
    // NOTE: Since some tests deliberately try to access non-existent files.
    // We might want to remove this warning (otherwise it will show
    // up in the debug.log every time).
    DebugLogger.warning('HttpServer: could not find file for request path: '
                        '"${request.path}"');
    response.statusCode = HttpStatus.NOT_FOUND;
    try {
      response.outputStream.close();
    } catch (e) {
      if (e is StreamException) {
        DebugLogger.warning('HttpServer: error while closing the response '
                            'stream: $e');
      } else {
        throw e;
      }
    }
  }

  static terminateHttpServers() {
    for (var server in serverList) server.close();
  }
}

// Helper class for displaying directory listings.
class _Entry {
  final String name;
  final String displayName;

  _Entry(this.name, this.displayName);

  int compareTo(_Entry other) {
    return name.compareTo(other.name);
  }
}
