import 'dart:async';
import 'package:toptracks/repositories/i_auth_repository.dart';

class AuthController {
  final IAuthRepository repository;
  AuthController(this.repository);

  Stream<String?>? _codeStream;
  String? _code;

  init() async {
    //  ._code.onData((data) {});
  }

  login() async {
    repository.login();
  }
}
