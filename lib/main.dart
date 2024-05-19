import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/src/app.dart';  // Certifique-se de que o arquivo app.dart esteja importado corretamente

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(

    ),
  );
  runApp(MyApp());
}
