import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/chat_manager.dart';
import 'package:nigga_chat/models/contact_model.dart';

part 'homeviewmodel_event.dart';
part 'homeviewmodel_state.dart';

class Homeviewmodel extends BaseModel<HomeviewmodelEvent, HomeviewmodelState> {
  final ChatManager _chatManager = locator<ChatManager>();
  Homeviewmodel()
      : super(HomeviewmodelLoading(), autoEvent: HomeviewmodelLoadEvent());

  @override
  Future<void> mapEventToState(HomeviewmodelEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
