import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String sentBy;
  final String sentTo;
  final Timestamp time;

  const ChatModel({
    required this.message,
    required this.sentBy,
    required this.sentTo,
    required this.time,
  });

  ChatModel copyWith({
    String? message,
    String? sentBy,
    String? sentTo,
    Timestamp? time,
  }) {
    return ChatModel(
      message: message ?? this.message,
      sentBy: sentBy ?? this.sentBy,
      sentTo: sentTo ?? this.sentTo,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sentBy': sentBy,
      'sentTo': sentTo,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'],
      sentBy: map['sentBy'],
      sentTo: map['sentTo'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(message: $message, sentBy: $sentBy, sentTo: $sentTo, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatModel &&
      other.message == message &&
      other.sentBy == sentBy &&
      other.sentTo == sentTo &&
      other.time == time;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      sentBy.hashCode ^
      sentTo.hashCode ^
      time.hashCode;
  }
}
