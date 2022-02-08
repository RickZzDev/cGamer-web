import 'dart:io';

import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/api_utils/api_path.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/cache_utils/cache_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class Requester {
  Map<String, String> basicHeaders = Headers().getBasicHeader();
  @Deprecated('use postv2')
  post(
      {String? url,
      dynamic body,
      Map<String, String>? header,
      Map<String, String>? params}) async {
    try {
      var response = await http.post(
        API().getUriComposed(url, params),
        headers: header == null ? basicHeaders : header,
        body: body != null ? jsonEncode(body) : null,
      );

      verifyStatusCode(response);

      return response;
    } catch (e) {
      return e;
    }
  }

  postV2(
      {String? url,
      dynamic body,
      Map<String, String>? header,
      Map<String, String>? params}) async {
    try {
      var response = await http.post(
        API().getUriComposed(url, params),
        headers: header == null ? basicHeaders : header,
        body: body != null ? jsonEncode(body) : null,
      );
//
      verifyStatusCode(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  fetch(
      {required String? url,
      Map<String, String>? header,
      bool containsBody = true,
      Map<String, String>? params,
      Uri? uri}) async {
    try {
      var response = await http.get(uri ?? API().getUriComposed(url, params),
          headers: header == null ? basicHeaders : header);

      verifyStatusCode(response);
      if (response.body != "" && containsBody) {
        json.decode(utf8.decode(response.bodyBytes));
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  put(
      {String? url,
      dynamic body,
      Map<String, String>? header,
      Map<String, String>? params}) async {
    try {
      var response = await http.put(API().getUriComposed(url, params),
          headers: header == null ? basicHeaders : header,
          body: jsonEncode(body));

      verifyStatusCode(response);

      return response;
    } catch (e) {
      return e;
    }
  }

  delete(
      {String? url,
      dynamic body,
      Map<String, String>? header,
      Map<String, String>? params}) async {
    try {
      var response = await http.delete(
        API().getUriComposed(url, params),
        headers: header == null ? basicHeaders : header,
        body: body != null ? jsonEncode(body) : null,
      );

      verifyStatusCode(response);

      return response;
    } catch (e) {
      return e;
    }
  }

  pdf({required String? url, Map<String, String>? header}) async {
    try {
      var response = await http.get(API().getUriComposed(url, null),
          headers: header == null ? basicHeaders : header);

      verifyStatusCode(response);
      return response;
    } catch (e) {
      return e;
    }
  }

  verifyStatusCode(http.Response _response) {
    if (_response.statusCode < 200 || _response.statusCode > 300) {
      if (_response.statusCode == 401) {
        CacheUtils.removeCache(key: 'x-token');
        return Get.offAllNamed(Routes.LOGIN);
      }
      if (_response.body == null) {
        throw new Exception("Error while fetching data");
      } else {
        Map mapError = json.decode(utf8.decode(_response.bodyBytes));
        throw new Exception(mapError['message']);
      }
    }
  }

  uploadDocuments(String documentType, File frontDocument, File backDocument,
      File selfie, String url, Map header) async {
    var frontDocumentStream =
        new http.ByteStream(Stream.castFrom(frontDocument.openRead()));
    var frontDocumentLength = await frontDocument.length();

    var backDocumentStream =
        new http.ByteStream(Stream.castFrom(backDocument.openRead()));
    var backDocumentLength = await backDocument.length();

    var selfieStream = new http.ByteStream(Stream.castFrom(selfie.openRead()));
    var selfieLength = await selfie.length();

    var uri = API().getUriComposed(url, null);

    var request = new http.MultipartRequest("POST", uri);
    request.headers['X-Token'] = header['X-Token'];
    request.headers['OS'] = header['OS'];

    var frontDocumentFile = new http.MultipartFile(
        'frontDocument', frontDocumentStream, frontDocumentLength,
        filename: 'frontDocument.jpeg',
        contentType: MediaType('image', 'jpeg'));

    var backDocumentFile = new http.MultipartFile(
        'backDocument', backDocumentStream, backDocumentLength,
        filename: 'backDocument.jpeg', contentType: MediaType('image', 'jpeg'));

    var selfieFile = new http.MultipartFile(
        'selfie', selfieStream, selfieLength,
        filename: 'selfie.jpeg', contentType: MediaType('image', 'jpeg'));

    request.fields['documentType'] = documentType;

    request.files.add(frontDocumentFile);
    request.files.add(backDocumentFile);
    request.files.add(selfieFile);

    var _uploadRequest = await request.send();
    if (_uploadRequest.statusCode == 200) {
      return _uploadRequest.statusCode;
    }
    verifyStreamStatusCode(_uploadRequest);
  }

  verifyStreamStatusCode(http.StreamedResponse _response) {
    if (_response.statusCode < 200 || _response.statusCode > 300) {
      if (_response.statusCode == 401) {
        CacheUtils.removeCache(key: 'x-token');
        return Get.offAllNamed(Routes.LOGIN);
      }

      throw new Exception("Ocorreu um erro ao tentar enviar seus documentos.");
    }
  }
}
