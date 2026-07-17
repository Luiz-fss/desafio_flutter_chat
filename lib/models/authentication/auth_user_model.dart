import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel {
  final String id;
  final String email;

  const AuthUserModel({
    required this.id,
    required this.email,
  });


  factory AuthUserModel.fromFirebaseUser(User user) {
    return AuthUserModel(
      id: user.uid,
      email: user.email ?? "",
    );
  }
}