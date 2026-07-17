import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/users/cubit_users.dart';
import '../../../../cubits/users/cubit_users_state.dart';
import '../../../components/share/empty_state.dart';
import '../../../components/users/user_card.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CubitUsers>().watchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CubitUsers, CubitUsersState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: BlocBuilder<CubitUsers, CubitUsersState>(
        builder: (context, state) {
          if (state.users == null || state.users!.isEmpty) {
            return const EmptyState(message: "Nenhum usuário encontrado");
          }
          return Container(
            decoration: BoxDecoration(
              gradient:  LinearGradient(
                colors: [
                  Color(0xFF764BA2),
                  Color(0xFF667EEA),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.users!.length,
              itemBuilder: (context, index) {
                final user = state.users![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: UserCard(user: user),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
