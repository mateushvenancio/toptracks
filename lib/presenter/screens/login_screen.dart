import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toptracks/core/constants.dart';
import 'package:toptracks/presenter/controllers/home_controller.dart';
import 'package:toptracks/repositories/i_auth_repository.dart';
import 'package:toptracks/repositories/i_storage_repository.dart';
import 'package:uni_links/uni_links.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription? _sub;

  _salvarRefreshToken(String code) async {
    await context.read<HomeController>().initializeTokenFromCode(code);
    context.go('/home');
  }

  _listenEvents() {
    _sub = linkStream.listen((event) async {
      if (event == null) return;
      final uri = Uri.tryParse(event);
      final code = uri?.queryParameters['code'];
      if (uri == null || code == null) return;

      log(code, name: 'Code!');

      _salvarRefreshToken(code);

      _sub?.cancel();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<IAuthRepository>().login();
            _listenEvents();
          },
          child: const Text('FAZER LOGIN'),
        ),
      ),
    );
  }
}
