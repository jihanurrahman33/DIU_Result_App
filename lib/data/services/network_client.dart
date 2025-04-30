import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/web.dart';

class NetworkResponse {
  final bool isSucess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;
  NetworkResponse({
    required this.isSucess,
    required this.statusCode,
    this.data,
    this.errorMessage,
  });
}

class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _preRequestLog(url);
      Response response = await get(
        uri,
      );
      _postRequestLog(
        url,
        response.statusCode,
        responseBody: response.body,
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSucess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSucess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorize user.Please login again',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went Wrong';
        return NetworkResponse(
          isSucess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1);
      return NetworkResponse(
        isSucess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _preRequestLog(
    String url, {
    Map<String, dynamic>? body,
  }) {
    _logger.i(
      'Body=> $body',
    );
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    dynamic responseBody,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        'Url=> $url\n'
        'Status Code=> $statusCode\n'
        'Error Message=> $errorMessage',
      );
    } else {
      _logger.i(
        'Url=> $url\n'
        'Status Code=> $statusCode\n'
        'Response=>$responseBody',
      );
    }
  }
}
