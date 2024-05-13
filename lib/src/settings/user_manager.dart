import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserManager {
  static const String _fileName = 'user_credentials.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<void> writeUser(Map<String, dynamic> user) async {
    final file = await _localFile;
    List<dynamic> users = [];
    if (await file.exists()) {
      String contents = await file.readAsString();
      users = json.decode(contents);
    }
    users.add(user);
    await file.writeAsString(json.encode(users));
  }

  Future<List<dynamic>> readUsers() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        return json.decode(contents);
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
