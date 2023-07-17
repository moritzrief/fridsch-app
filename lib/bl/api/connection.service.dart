import 'package:dio/dio.dart';

Dio kDio = Dio(BaseOptions(
  baseUrl: kBaseUrl,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
));

const String kBaseUrl = 'http://localhost:3333/';