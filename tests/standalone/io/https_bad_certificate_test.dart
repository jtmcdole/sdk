// Copyright (c) 2013, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This test verifies that the bad certificate callback works in HttpClient.

import "dart:async";
import "dart:io";

import "package:expect/expect.dart";

final HOST_NAME = 'localhost';

String localFile(path) => Platform.script.resolve(path).toFilePath();
List<int> readLocalFile(path) => (new File(localFile(path))).readAsBytesSync();

SecurityContext serverContext = new SecurityContext()
  ..useCertificateChainBytes(readLocalFile('certificates/server_chain.pem'))
  ..usePrivateKeyBytes(readLocalFile('certificates/server_key.pem'),
                         password: 'dartdart');

class CustomException {}

main() async {
  var HOST = (await InternetAddress.lookup(HOST_NAME)).first;
  var server = await HttpServer.bindSecure(HOST, 0, serverContext, backlog: 5);
  server.listen((request) {
    request.listen((_) {
    }, onDone: () {
      request.response.close();
    });
  });

  SecurityContext goodContext = new SecurityContext()
    ..setTrustedCertificates(file: localFile('certificates/trusted_certs.pem'));
  SecurityContext badContext = new SecurityContext();
  SecurityContext defaultContext = SecurityContext.defaultContext;

  await runClient(server.port, goodContext, true, 'pass');
  await runClient(server.port, goodContext, false, 'pass');
  await runClient(server.port, goodContext, 'fisk', 'pass');
  await runClient(server.port, goodContext, 'exception', 'pass');
  await runClient(server.port, badContext, true, 'pass');
  await runClient(server.port, badContext, false, 'fail');
  await runClient(server.port, badContext, 'fisk', 'fail');
  await runClient(server.port, badContext, 'exception', 'throw');
  await runClient(server.port, defaultContext, true, 'pass');
  await runClient(server.port, defaultContext, false, 'fail');
  await runClient(server.port, defaultContext, 'fisk', 'fail');
  await runClient(server.port, defaultContext, 'exception', 'throw');
  server.close();
}


Future runClient(int port,
                 SecurityContext context,
                 callbackReturns,
                 result) async {
  HttpClient client = new HttpClient(context: context);
  client.badCertificateCallback = (X509Certificate certificate, host, port) {
    Expect.equals('/CN=rootauthority', certificate.subject);
    Expect.equals('/CN=rootauthority', certificate.issuer);
    // Throw exception if one is requested.
    if (callbackReturns == 'exception') throw new CustomException();
    return callbackReturns;
  };

  try {
    var request = await client.getUrl(Uri.parse('https://$HOST_NAME:$port/'));
    Expect.equals('pass', result);
    await request.close();
  } catch (error) {
    Expect.notEquals(result, 'pass');
    if (result == 'fail') {
      Expect.isTrue(error is HandshakeException);
    } else if (result == 'throw') {
      Expect.isTrue(error is CustomException);
    } else {
      Expect.fail('Unknown expectation $result');
    }
  }
}
