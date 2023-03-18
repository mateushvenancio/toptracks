import 'dart:convert';

import 'package:toptracks/core/constants.dart';
import 'package:toptracks/datasource/api_datasource/connect/i_api_connect.dart';
import 'package:toptracks/repositories/i_auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiAuthRepository implements IAuthRepository {
  final IApiConnect connect;

  ApiAuthRepository(this.connect);

  @override
  Future<void> login() async {
    final url = Uri.https(
      'accounts.spotify.com',
      '/authorize',
      {
        'client_id': kClientPublic,
        'redirect_uri': kRedirectUri,
        'response_type': 'code',
        'scope': 'user-top-read',
      },
    );
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<String> getToken(String refreshToken) async {
    final bytes = utf8.encode('$kClientPublic:$kClientSecret');
    final encoded = base64.encode(bytes);

    final response = await connect.post(
      'https://accounts.spotify.com/api/token',
      headers: {
        'Authorization': 'Basic $encoded',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      },
    );

    final token = response['access_token'] as String;

    return token;
  }

  @override
  Future<String> getRefreshToken(String code) async {
    final bytes = utf8.encode('$kClientPublic:$kClientSecret');
    final encoded = base64.encode(bytes);

    final uri = Uri.https(
      'accounts.spotify.com',
      'api/token',
      {
        'client_id': kClientPublic,
        'client_secret': kClientSecret,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': kRedirectUri,
      },
    );

    final response = await connect.post(
      uri.toString(),
      headers: {
        'Authorization': 'Basic $encoded',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final token = response['refresh_token'] as String;

    return token;
  }
}
