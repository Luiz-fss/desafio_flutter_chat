import 'package:flutter/material.dart';

import '../ui/screens/authentication/login/login_screen.dart';
import '../ui/screens/authentication/register/register_screen.dart';
import '../ui/screens/home/chat/chat_screen.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/home/users/users_screen.dart';
import '../ui/screens/splash/splash_screen.dart';

import 'app_routes.dart';


class AppRouter {

  static Route<dynamic> generateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.users:
        return MaterialPageRoute(
          builder: (_) => const UsersScreen(),
        );

      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => const ChatScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}