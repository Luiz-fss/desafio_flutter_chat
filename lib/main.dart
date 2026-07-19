import 'package:chat_realtime/routes/app_router.dart';
import 'package:chat_realtime/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configuration/dependency/app_dependency.dart';
import 'configuration/dependency/service_locator.dart';

import 'cubits/auth/cubit_auth.dart';
import 'cubits/chat/cubit_chat.dart';
import 'cubits/register/cubit_register.dart';
import 'cubits/users/cubit_users.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppDependencies().register();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CubitAuth>(
          create: (_) => ServiceLocator.get<CubitAuth>(),
        ),
        BlocProvider<CubitUsers>(
          create: (_) => ServiceLocator.get<CubitUsers>(),
        ),
        BlocProvider<CubitChat>(
          create: (_) => ServiceLocator.get<CubitChat>(),
        ),
        BlocProvider<CubitRegister>(
          create: (_) => ServiceLocator.get<CubitRegister>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat realtime',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
    );
  }
}