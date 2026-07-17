import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/auth/cubit_auth_state.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CubitAuth, CubitAuthState>(
      listener: (_, state) {
        _handleNavigation(state);
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  void _handleNavigation(CubitAuthState state) {
    if (!state.isInitialized) {
      return;
    }

    if (state.user != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
            (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (route) => false,
      );
    }
  }
}
