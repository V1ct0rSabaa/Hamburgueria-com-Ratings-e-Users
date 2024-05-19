import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/item_list_view.dart';
import 'screens/register_hamburgueria_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Integration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      routes: {
        '/items': (context) => ItemListView(),
        '/register': (context) => RegisterHamburgueriaScreen(),  // Adicionar rota para a tela de registro
      },
    );
  }
}
