import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String? senderId;
  final String? senderName;
  final String? text;
  final DateTime? createdAt;

  const MessageModel({
    required this.id,
    this.senderId,
    this.senderName,
    this.text,
    this.createdAt,
  });

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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'createdAt': createdAt,
    };
  }
}