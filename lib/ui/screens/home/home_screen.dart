import 'package:chat_realtime/ui/screens/home/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/auth/cubit_auth.dart';
import '../../../cubits/auth/cubit_auth_state.dart';
import '../../../cubits/users/cubit_users.dart';
import '../../../routes/app_routes.dart';
import '../../components/home/home_app_bar.dart';
import 'chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;

  final List<Widget> _pages = const [UsersScreen(), ChatScreen()];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final user = context.read<CubitAuth>().state.user;
    if (user != null) {
      context.read<CubitUsers>().loadLoggedUser(user.id);
      context.read<CubitUsers>().updatePresence(
        userId: user.id,
        isOnline: true,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final user = context.read<CubitAuth>().state.user;
    if (user == null) {
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      context.read<CubitUsers>().updatePresence(
        userId: user.id,
        isOnline: false,
      );
    }
    if (state == AppLifecycleState.resumed) {
      context.read<CubitUsers>().updatePresence(
        userId: user.id,
        isOnline: true,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CubitAuth, CubitAuthState>(
      listener: (context, state) {
        if (state.user == null && state.isInitialized) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          return;
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: HomeAppBar(
            title: _currentIndex == 0 ? "Usuários" : "Chat",
            onLogout: () async {
              final user = context.read<CubitAuth>().state.user;
              if (user != null) {
                await context.read<CubitUsers>().updatePresence(
                  userId: user.id,
                  isOnline: false,
                );
              }
              await context.read<CubitAuth>().logout();
            },
          ),
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Usuários",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            ],
          ),
        ),
      ),
    );
  }
}
