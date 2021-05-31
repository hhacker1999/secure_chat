import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/auth_manager.dart';
import 'package:nigga_chat/managers/chat_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:nigga_chat/models/chat_model.dart';
part 'package:nigga_chat/views/chat_view/chat_view_model/chat_view_event.dart';
part 'package:nigga_chat/views/chat_view/chat_view_model/chat_view_state.dart';

@lazySingleton
class ChatViewModel extends BaseModel<ChatViewEvent, ChatViewState> {
  final ChatManager _chatManager = locator<ChatManager>();
  final AuthManager _authManager = locator<AuthManager>();
  ChatViewModel() : super(ChatViewStateLoading());

  @override
  Future<void> mapEventToState(ChatViewEvent event) async {
    if (event is LoadChatEvent) {
      await getMessages(event.other);
    } else if (event is SendMessageEvent) {
      var result = await _authManager.currentUser();
      ChatModel model = ChatModel(
          message: event.message,
          sentBy: result.phoneNumber,
          sentTo: event.other,
          time: event.time);
      await _chatManager.saveMessages(result.phoneNumber, event.other, model);
    }
  }

  Future<void> getMessages(String other) async {
    _chatManager.getMessages(other).listen((event) {
      if (event.length != 0)
        updateState(ChatViewStateLoaded(model: event));
      else
        updateState(ChatViewLoadedwithNoData());
    });
  }
}
