import 'package:dio/dio.dart';

class NewsAppDioHelper {
  static late Dio dio;

// initial url
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

//get data from url
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}
