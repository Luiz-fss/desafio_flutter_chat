import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String? name;
  final String? email;
  final bool? isOnline;
  final DateTime? lastSeen;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.isOnline,
    this.lastSeen,
  });

  factory UserModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return UserModel(
      id: id,
      name: map['name'],
      email: map['email'],
      isOnline: map['isOnline'],
      lastSeen: map['lastSeen'] != null
          ? (map['lastSeen'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }
}