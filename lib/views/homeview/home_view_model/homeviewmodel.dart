import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/chat_manager.dart';
import 'package:nigga_chat/models/contact_model.dart';
import 'package:nigga_chat/models/conversation_model.dart';

part 'homeviewmodel_event.dart';
part 'homeviewmodel_state.dart';

@lazySingleton
class Homeviewmodel extends BaseModel<HomeviewmodelEvent, HomeviewmodelState> {
  final ChatManager _chatManager = locator<ChatManager>();
  Homeviewmodel()
      : super(HomeviewmodelLoading(), autoEvent: HomeviewmodelLoadEvent());

  @override
  Future<void> mapEventToState(HomeviewmodelEvent event) async {
    await _getConversations();
  }

  Future<void> _getConversations() async {
    var result = await _chatManager.getConversationsList();
    if (result.length == 0)
      updateState(HomeviewLoadedwithNoData());
    else
      updateState(HomeviewLoadedwithData(result));
  }
}
