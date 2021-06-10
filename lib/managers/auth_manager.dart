import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/models/user_model.dart';
import 'package:nigga_chat/services/auth_service.dart';
import 'package:nigga_chat/services/firebase_service.dart';
import 'package:nigga_chat/services/local_data_service.dart';

@lazySingleton
class AuthManager {
  final _authService = locator<AuthService>();
  final _firebaseService = locator<FirebaseService>();
  final _localDataService = locator<LocalDataService>();

  Future<bool> autoSignIn(PhoneAuthCredential cred, String phoneNumber) async {
    var result = await isNewUser(phoneNumber);
    await _authService.signInWithAuthCredentials(cred);
    await _firebaseService.logInUser(phoneNumber);

    return !result;
  }

  Future<bool> otpSignIn(
      String verId, String smsCode, String phoneNumber) async {
    var result = await isNewUser(phoneNumber);
    await _authService.signInWithSmsCode(verId, smsCode);
    await _firebaseService.logInUser(phoneNumber);
    return !result;
  }

  Future<bool> isNewUser(String phoneNumber) async {
    return await _firebaseService.isUserRegistered(phoneNumber);
  }

  Future<void> saveUserName(String phoneNumber, String name) async {
    var modelToEncode = UserModel(name: name, phoneNumber: phoneNumber);
    var modelToSave = modelToEncode.toJson();
    await _localDataService.create('user', modelToSave);
    await _firebaseService.saveUserName(phoneNumber, name);
  }

  Future<void> saveUserNameToLocalData() async {
    var result = await _authService.currentUser();
    var userName = await _firebaseService.getUserName(result.phoneNumber);

    var modelToEncode =
        UserModel(name: userName, phoneNumber: result.phoneNumber ?? '');
    var modelToSave = modelToEncode.toJson();

    await _localDataService.create('user', modelToSave);
  }

  Future<UserModel> currentUser() async {
    var result = await _localDataService.read('user');
    return UserModel.fromJson(result);
  }

  Future<bool> isLoggedIn() async {
    return _authService.isLoggedIn();
  }
}
