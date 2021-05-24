import 'dart:convert';

class ContactModel {
  String phoneNumber;
  ContactModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));
}
