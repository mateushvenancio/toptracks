import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toptracks/core/constants.dart';
import 'package:toptracks/repositories/i_storage_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    final code = await context.read<IStorageRepository>().loadString(kRefreshToken);
    if (code != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu app'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('LOGIN'),
          onPressed: () {},
        ),
      ),
    );
  }
}
