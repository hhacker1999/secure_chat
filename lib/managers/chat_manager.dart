import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/models/contact_model.dart';
import 'package:nigga_chat/models/user_model.dart';
import 'package:nigga_chat/services/firebase_service.dart';
import 'package:nigga_chat/services/local_data_service.dart';

@lazySingleton
class ChatManager {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final LocalDataService _dataService = locator<LocalDataService>();

  Future<List<ContactModel>> getConversationsList() async {
    List<ContactModel> _list = [];
    var userString = await _dataService.read('user');
    var user = UserModel.fromJson(userString);
    var result = await _firebaseService.getConversations(user.phoneNumber);
    result.forEach((element) {
      _list.add(ContactModel(phoneNumber: element));
    });
    return _list;
  }
}
