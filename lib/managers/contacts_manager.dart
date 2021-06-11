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
      _listPhones.add(contact.phones!.toList()[0].value);
    });
    _listPhones.forEach(
      (element) {
        element!.replaceAll(' ', '');
      },
    );

    _listPhones.asMap().entries.forEach((element) {
      _mapList.add({
        'phoneNumber': element.value,
        'name': _listNames[element.key],
      });
    });
    var encodeList = json.encode(_mapList);
    await _localDataService.create('contacts', encodeList);
  }

  Future<List<ContactModel>> getContacts() async {
    var result = await _localDataService.read('contacts');
    List listToConvert = json.decode(result);
    return listToConvert.map((e) => ContactModel.fromMap(e)).toList();
  }
}
