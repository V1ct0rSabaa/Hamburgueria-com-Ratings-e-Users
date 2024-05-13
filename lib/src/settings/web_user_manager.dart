import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class WebUserManager {
  final LocalStorage storage = LocalStorage('user_credentials');

  Future<void> writeUser(Map<String, dynamic> user) async {
    await storage.ready;
    List<dynamic> users = [];
    var storedData = storage.getItem('users');
    if (storedData != null) {
      users = json.decode(storedData);
    }
    users.add(user);
    storage.setItem('users', json.encode(users));
  }

  Future<List<dynamic>> readUsers() async {
    await storage.ready;
    var storedData = storage.getItem('users');
    if (storedData != null) {
      return json.decode(storedData);
    }
    return [];
  }
}
