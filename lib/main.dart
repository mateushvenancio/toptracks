import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toptracks/datasource/api_datasource/api_auth_repository.dart';
import 'package:toptracks/datasource/api_datasource/api_items_repository.dart';
import 'package:toptracks/datasource/api_datasource/connect/dio_api_connect.dart';
import 'package:toptracks/datasource/api_datasource/connect/i_api_connect.dart';
import 'package:toptracks/datasource/local_datasource/secure_storage_repository.dart';
import 'package:toptracks/presenter/controllers/home_controller.dart';
import 'package:toptracks/presenter/screens/home_screen.dart';
import 'package:toptracks/presenter/screens/login_screen.dart';
import 'package:toptracks/presenter/screens/splash_screen.dart';
import 'package:toptracks/repositories/i_auth_repository.dart';
import 'package:toptracks/repositories/i_items_repository.dart';
import 'package:toptracks/repositories/i_storage_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IApiConnect>(
          create: (_) => DioApiConnect(),
          lazy: true,
        ),
        Provider<IAuthRepository>(
          create: (context) => ApiAuthRepository(context.read<IApiConnect>()),
          lazy: true,
        ),
        Provider<IStorageRepository>(
          create: (_) => SecureStorageRepository(),
          lazy: true,
        ),
        Provider<IItemsRepository>(
          create: (context) => ApiItemsRepository(context.read<IApiConnect>()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(
            authRepository: context.read<IAuthRepository>(),
            itemsRepository: context.read<IItemsRepository>(),
            storageRepository: context.read<IStorageRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Top Tracks',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            background: Color(0xff393E46),
          ),
          textTheme: GoogleFonts.cousineTextTheme(
            const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
