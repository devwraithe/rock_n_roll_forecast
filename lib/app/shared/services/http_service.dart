import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../errors/exceptions.dart';
import '../errors/failure.dart';
import '../utilities/constants.dart';

abstract class HttpService {
  Future<Map<String, dynamic>> getRequest(
    String url, {
    Map<String, String>? headers,
    required String errorMessage,
  });
}

class HttpServiceImpl implements HttpService {
  final client = HttpClient();

  @override
  Future<Map<String, dynamic>> getRequest(
    String url, {
    Map<String, String>? headers,
    required String errorMessage,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException(Failure(errorMessage));
      }
    } on SocketException {
      throw NetworkException(Failure(Constants.lostConnection));
    } on TimeoutException {
      throw NetworkException(Failure(Constants.connectionTimeout));
    } on http.ClientException catch (e) {
      throw NetworkException(Failure(e.message));
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception(Failure(e.toString()));
    }
  }
}
