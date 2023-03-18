import 'package:dio/dio.dart';
import 'package:toptracks/datasource/api_datasource/connect/i_api_connect.dart';

class DioApiConnect implements IApiConnect {
  final dio = Dio(
    BaseOptions(
      validateStatus: (status) => (status ?? 500) < 500,
    ),
  );

  @override
  Future<dynamic> get(String path, {Map<String, String>? headers}) async {
    final response = await dio.get(path, options: Options(headers: headers));
    return response.data;
  }

  @override
  Future<dynamic> post(String path, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    final response = await dio.post(path, data: data, options: Options(headers: headers));
    return response.data;
  }
}
