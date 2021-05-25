import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseService {
  final _instance = FirebaseFirestore.instance;

  Future<bool> logInUser(String? phoneNumber) async {
    var data = await _instance.collection('users').doc(phoneNumber).get();
    if (!data.exists)
      return await _userRegistration(phoneNumber);
    else
      return true;
  }

  Future<bool> isUserRegistered(String phoneNumber) async {
    var data = await _instance.collection('users').doc(phoneNumber).get();
    if (!data.exists)
      return false;
    else
      return true;
  }

  Future<String> getUserName(String? phoneNumber) async {
    String _name = '';
    await _instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => _name = value.data()!['name']);
    return _name;
  }

  Future<bool> _userRegistration(String? phoneNumber) async {
    try {
      await _instance.collection('users').doc(phoneNumber).set({
        'userPhone': phoneNumber,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveUserName(String? phoneNumber, String? name) async {
    try {
      await _instance.collection('users').doc(phoneNumber).update({
        'name': name,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String other, String phoneNumber) {
    return _instance
        .collection('users')
        .doc(phoneNumber)
        .collection('conversations')
        .doc(other)
        .collection('messages')
        .snapshots();
  }

  Future<List<String>> getConversations(String phoneNumber) async {
    List<String> _conversations = [];
    await _instance
        .collection('users')
        .doc(phoneNumber)
        .collection('conversations')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (doc) {
            _conversations.add(doc.id);
          },
        );
      },
    );
    return _conversations;
  }
}
