import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String? senderId;
  final String? senderName;
  final String? text;
  final DateTime? createdAt;
  final DateTime? editedAt;
  final bool deleted;

  const MessageModel({
    required this.id,
    this.senderId,
    this.senderName,
    this.text,
    this.createdAt,
    this.editedAt,
    this.deleted = false,
  });

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? text,
    DateTime? createdAt,
    DateTime? editedAt,
    bool? deleted,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  factory MessageModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return MessageModel(
      id: id,
      senderId: map['senderId'] as String?,
      senderName: map['senderName'] as String?,
      text: map['text'] as String?,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      editedAt: map['editedAt'] != null
          ? (map['editedAt'] as Timestamp).toDate()
          : null,
      deleted: map['deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'createdAt': createdAt,
      'editedAt': editedAt,
      'deleted': deleted,
    };
  }
}