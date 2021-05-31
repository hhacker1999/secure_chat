import 'dart:convert';

class ContactModel {
  final  String phoneNumber;
  final String name;
  ContactModel({
    required this.phoneNumber,
    required this.name,
  });

  ContactModel copyWith({
    String? phoneNumber,
    String? name,
  }) {
    return ContactModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      phoneNumber: map['phoneNumber'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactModel(phoneNumber: $phoneNumber, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContactModel &&
      other.phoneNumber == phoneNumber &&
      other.name == name;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ name.hashCode;
}
