import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/models/contact_model.dart';
import 'package:nigga_chat/services/contacts_service.dart';
import 'package:nigga_chat/services/local_data_service.dart';
import 'package:nigga_chat/services/permission_handler.dart';

@lazySingleton
class ContactsManager {
  final AppContactsService _contactsService = locator<AppContactsService>();
  final PermissionHandlerServices _permissionHandlerServices =
      locator<PermissionHandlerServices>();
  final LocalDataService _localDataService = locator<LocalDataService>();

  Future<void> getAndSaveContactsOnStartup() async {
    List<String?> _list = [];
    await _permissionHandlerServices.requestContactsPermission();
    var result = await _contactsService.getContacts();
    result.forEach((contact) {
      contact.phones!.toSet().forEach((phone) {
        _list.add(phone.value);
      });
    });
    _list.forEach(
      (element) {
        element!.replaceAll(' ', '');
      },
    );
    var listToSave = _list.map((e) => ContactModel(phoneNumber: e!)).toList();
var encodedList = listToSave.map((e) => e.toJson()).toList();
    var encodeList = json.encode(encodedList);
    await _localDataService.create('contacts', encodeList);
  }

  Future<List<ContactModel>> getContacts() async {
    var result = await _localDataService.read('contacts');
    return json.decode(result);
  }
}
