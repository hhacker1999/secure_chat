import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithAuthCredentials(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithSmsCode(String verificationId, String smsCode) async {
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await signInWithAuthCredentials(_credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    var result = _auth.currentUser;
    return result != null;
  }
}
