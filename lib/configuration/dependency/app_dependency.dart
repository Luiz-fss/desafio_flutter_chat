import 'package:chat_realtime/configuration/dependency/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../cubits/auth/cubit_auth.dart';
import '../../cubits/chat/cubit_chat.dart';
import '../../cubits/register/cubit_register.dart';
import '../../cubits/users/cubit_users.dart';
import '../../repositories/authentication/firebase_auth_repository_impl.dart';
import '../../repositories/authentication/i_auth_repository.dart';
import '../../repositories/chat/firebase_chat_repository_impl.dart';
import '../../repositories/chat/i_chat_repository.dart';
import '../../repositories/users/firebase_users_repository_impl.dart';
import '../../repositories/users/i_user_repository.dart';

class AppDependencies {
  void register() {
    ServiceLocator.registerLazy<FirebaseAuth>(
          () => FirebaseAuth.instance,
    );
    ServiceLocator.registerLazy<FirebaseFirestore>(
          () => FirebaseFirestore.instance,
    );

    ServiceLocator.registerLazy<IAuthRepository>(
          () => FirebaseAuthRepositoryImpl(
        ServiceLocator.get<FirebaseAuth>(),
      ),
    );
    ServiceLocator.registerLazy<IUsersRepository>(
          () => FirebaseUsersRepositoryImpl(
        ServiceLocator.get<FirebaseFirestore>(),
      ),
    );
    ServiceLocator.registerLazy<IChatRepository>(
          () => FirebaseChatRepositoryImpl(
        ServiceLocator.get<FirebaseFirestore>(),
      ),
    );

    ServiceLocator.registerLazy<CubitAuth>(
          () => CubitAuth(
        ServiceLocator.get<IAuthRepository>(),
      ),
    );
    ServiceLocator.registerLazy<CubitUsers>(
          () => CubitUsers(
        ServiceLocator.get<IUsersRepository>(),
      ),
    );
    ServiceLocator.registerLazy<CubitChat>(
          () => CubitChat(
        ServiceLocator.get<IChatRepository>()
      ),
    );
    ServiceLocator.registerLazy<CubitRegister>(
          () => CubitRegister(
        ServiceLocator.get<IAuthRepository>(),
        ServiceLocator.get<IUsersRepository>(),
      ),
    );
  }
}