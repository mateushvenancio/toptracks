abstract class IApiConnect {
  Future<dynamic> get(String path, {Map<String, String>? headers});
  Future<dynamic> post(String path, {Map<String, dynamic>? data, Map<String, String>? headers});
}
