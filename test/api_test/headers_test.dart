import 'dart:io';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

// class HttpClientSpy extends Mock implements Requester {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final Headers sut = Headers();
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  test(
    "Should receive basic header with corect values",
    () {
      Map<String, dynamic> expectedResult = {
        "OS": Platform.isAndroid ? "Android" : "iOS",
        "Content-Type": "application/json",
      };
      final result = sut.getBasicHeader();
      expect(result, expectedResult);
    },
  );

  test(
    "Should receive auth header with corect values",
    () async {
      final token = await Headers().getToken();
      Map<String, String> authenticatedHeaders = {
        "X-Token": token,
        "OS": Platform.isAndroid ? "Android" : "iOS",
        "Content-Type": "application/json",
        // "App-Version": version
      };
      final result = sut.getAuthenticatedHeader();
      expect(result, authenticatedHeaders);
    },
  );
}
