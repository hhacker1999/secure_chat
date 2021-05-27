import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String phoneNumber;
  final String name;
  final String message;
  final Timestamp time;
 const  ConversationModel({
    required this.phoneNumber,
    required this.name,
    required this.message,
    required this.time,
  });

  ConversationModel copyWith({
    String? phoneNumber,
    String? name,
    String? message,
    Timestamp? time,
  }) {
    return ConversationModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'message': message,
      'time': time,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      message: map['message'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) => ConversationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversationModel(phoneNumber: $phoneNumber, name: $name, message: $message, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ConversationModel &&
      other.phoneNumber == phoneNumber &&
      other.name == name &&
      other.message == message &&
      other.time == time;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
      name.hashCode ^
      message.hashCode ^
      time.hashCode;
  }
}
