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
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<void> saveMessages(
      String phoneNumber, String other, Map<String, dynamic> map) async {
    await _instance
        .collection('users')
        .doc(phoneNumber)
        .collection('conversations')
        .doc(other)
        .collection('messages')
        .add(map);
  }

  Future<List<Map<String, dynamic>>> getConversations(
      String phoneNumber) async {
    List<String> _conversations = [];
    List<String> _names = [];
    List<Map<String, dynamic>> _lastMessages = [];

    List<Map<String, dynamic>> _completeConversation = [];
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

    await Future.forEach<String>(_conversations, (element) async {
      var lastMessage = await _instance
          .collection('users')
          .doc(phoneNumber)
          .collection('conversations')
          .doc(element)
          .collection('messages')
          .orderBy('time', descending: true)
          .get();

      _lastMessages.add(lastMessage.docs.first.data());
    });

    await Future.forEach<String>(_conversations, (element) async {
      var names = await _instance.collection('users').doc(element).get();

      _names.add(names.data()!['name']);
    });

    for (int i = 0; i < _conversations.length; i++) {
      _completeConversation.add({
        'phoneNumber': _conversations[i],
        'name': _names[i],
        'message': _lastMessages[i]['message'],
        'time': _lastMessages[i]['time']
      });
    }
    return _completeConversation;
  }
}
