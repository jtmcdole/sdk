// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

import "dart:isolate";
import "dart:io";

void test(int totalConnections, [String body]) {
  HttpServer.bind().then((server) {

    server.listen((HttpRequest request) {
      HttpResponse response = request.response;
      // Cannot mutate request headers.
      Expect.throws(() => request.headers.add("X-Request-Header", "value"),
                    (e) => e is HttpException);
      Expect.equals("value", request.headers.value("X-Request-Header"));
      request.listen((_) {}, onDone: () {
        // Can still mutate response headers as long as no data has been sent.
        response.headers.add("X-Response-Header", "value");
        if (body != null) {
          response.addString(body);
          // Cannot mutate response headers when data has been sent.
          Expect.throws(() => request.headers.add("X-Request-Header", "value2"),
                        (e) => e is HttpException);
        }
        response..close();
        // Cannot mutate response headers when data has been sent.
        Expect.throws(() => request.headers.add("X-Request-Header", "value3"),
                      (e) => e is HttpException);
      });
    });

    int count = 0;
    HttpClient client = new HttpClient();
    for (int i = 0; i < totalConnections; i++) {
      client.get("127.0.0.1", server.port, "/")
        .then((HttpClientRequest request) {
          if (body != null) {
            request.contentLength = -1;
          }
          // Can still mutate request headers as long as no data has been sent.
          request.headers.add("X-Request-Header", "value");
          if (body != null) {
            request.addString(body);
            // Cannot mutate request headers when data has been sent.
            Expect.throws(
                () => request.headers.add("X-Request-Header", "value2"),
                (e) => e is HttpException);
          }
          request.close();
          // Cannot mutate request headers when data has been sent.
          Expect.throws(() => request.headers.add("X-Request-Header", "value3"),
                        (e) => e is HttpException);
          return request.response;
        })
        .then((HttpClientResponse response) {
          // Cannot mutate response headers.
          Expect.throws(
              () => response.headers.add("X-Response-Header", "value"),
              (e) => e is HttpException);
          Expect.equals("value", response.headers.value("X-Response-Header"));
          response.listen((_) {}, onDone: () {
            // Do not close the connections before we have read the
            // full response bodies for all connections.
            if (++count == totalConnections) {
              client.close();
              server.close();
            }
          });
        });
    }

  });
}

void main() {
  test(5);
  test(5, "Hello and goodbye");
}
