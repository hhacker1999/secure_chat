import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionHandlerServices {
  Future<PermissionStatus> contactsPermissionStatus() async {
    return await Permission.contacts.status;
  }

  Future requestContactsPermission() async {
    await [Permission.contacts].request();
  }
}
