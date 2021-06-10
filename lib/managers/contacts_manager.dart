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
    List<String?> _listPhones = [];
    List<String?> _listNames = [];
    List<Map<String, dynamic>> _mapList = [];
    await _permissionHandlerServices.requestContactsPermission();
    var result = await _contactsService.getContacts();
    result.forEach((contact) {
      _listNames.add(contact.displayName);
      contact.phones!.toSet().forEach((phone) {
        _listPhones.add(phone.value);
      });
    });
    _listPhones.forEach(
      (element) {
        element!.replaceAll(' ', '');
      },
    );

    for (int i = 0; i < _listPhones.length; i++) {
      _mapList.add({
        'phoneNumber': _listPhones[i],
        'name': _listNames[i],
      });
    }

    var encodeList = json.encode(_mapList);
    await _localDataService.create('contacts', encodeList);
  }

  Future<List<ContactModel>> getContacts() async {
    var result = await _localDataService.read('contacts');
    List listToConvert = json.decode(result);
    return listToConvert.map((e) => ContactModel.fromMap(e)).toList();
  }
}
