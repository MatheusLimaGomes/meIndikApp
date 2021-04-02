import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

const kServerError = 'Failed to connect to the server. Try again Later.';
final apiKey = FlutterConfig.get('API_KEY');
final baseUrl = FlutterConfig.get('BASE_URL');

final kDioOptions = BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  contentType: 'application/json;charset=utf-8',
  headers: {'Authorization': 'Bearer $apiKey'},
);
