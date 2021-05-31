import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/managers/contacts_manager.dart';
import 'package:nigga_chat/models/contact_model.dart';

part 'contactsview_event.dart';
part 'contactsview_state.dart';

@lazySingleton
class ContactsviewModel
    extends BaseModel<ContactsviewEvent, ContactsviewState> {
  final ContactsManager _contactsManager = locator<ContactsManager>();
  ContactsviewModel()
      : super(ContactsviewInitial(), autoEvent: GetContactsListEvent());

  @override
  Future<void> mapEventToState(ContactsviewEvent event) async {
    if (event is GetContactsListEvent) {
      var result = await _contactsManager.getContacts();
      if (result.length != 0)
        updateState(ContactsViewLoadedWithData(modelList: result));
      else
        updateState(ContactsViewLoadedWithNoData());
    }
  }
}
