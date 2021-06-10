import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/models/chat_model.dart';
import 'package:nigga_chat/models/conversation_model.dart';
import 'package:nigga_chat/models/user_model.dart';
import 'package:nigga_chat/services/firebase_service.dart';
import 'package:nigga_chat/services/local_data_service.dart';

@lazySingleton
class ChatManager {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final LocalDataService _dataService = locator<LocalDataService>();

  String? userPhone;

  Future<List<ConversationModel>> getConversationsList() async {
    List<ConversationModel> _list = [];
    if (userPhone == null) {
      var userString = await _dataService.read('user');
      var user = UserModel.fromJson(userString);
      userPhone = user.phoneNumber;
    }
    var result = await _firebaseService.getConversations(userPhone!);

    result.forEach((element) {
      _list.add(ConversationModel.fromMap(element));
    });
    return _list;
  }

  Future<void> saveMessages(
      String phoneNumber, String other, ChatModel model) async {
    await _firebaseService.saveMessages(phoneNumber, other, model.toMap());
    await _firebaseService.saveMessages(other, phoneNumber, model.toMap());
  }

  Stream<List<ChatModel>> getMessages(String other) {
    return _firebaseService.getMessages(other, userPhone!).map(
          (event) => event.docs
              .map(
                (e) => ChatModel.fromMap(e.data()),
              )
              .toList(),
        );
  }
}
