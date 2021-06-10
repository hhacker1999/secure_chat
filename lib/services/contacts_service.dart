import 'package:contacts_service/contacts_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppContactsService {
  Future<List<Contact>> getContacts() async {
    var result = await ContactsService.getContacts(withThumbnails: false);
    var listResult = result.toList();
    return listResult;
  }
}
