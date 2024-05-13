import 'package:flutter/foundation.dart' show kIsWeb;
import '../settings/user_manager.dart';
import '../settings/web_user_manager.dart';  // Importando o novo WebUserManager
import '../views/item_list_view.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool jaCadastrou = true;
  final Color? corTextoEspecial = Colors.blue[700];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Atribui a chave global para o formulário
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                showCursor: true,
                decoration: const InputDecoration(labelText: ("email")),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "O email não pode estar vázio!";
                  }
                  if (!value.contains("@")) {
                    return "O email deve conter \"@\"";
                  }
                  if (value.startsWith("@") ||
                      value.endsWith("@") ||
                      value.length <= 4) {
                    return "Formato de email inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                showCursor: true,
                obscureText: true,
                decoration: const InputDecoration(labelText: ("senha")),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "A senha não pode estar vazia";
                  }
                  final regex = RegExp(r'^[a-zA-Z]{6,20}$');
                  if(!regex.hasMatch(value)){
                    const min = 6;
                    const max = 20;
                    if(value.length < min || value.length > max) {
                      return "A senha deve ter de $min  a $max caracteres";
                    }
                    return "Formato de senha inválida, digite apenas letras maiúsculas ou minúsculas";
                  }
                  return null;
                },
              ),
              /*Visibility(
                visible: jaCadastrou,
                child: TextFormField(
                  decoration: const InputDecoration(label: Text("username")),
                ),
              ),*/
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                            dynamic userManager;
                            if (kIsWeb) {
                              userManager = WebUserManager();  // Usa o gerenciador de usuários da web
                            } else {
                              userManager = UserManager();  // Usa o gerenciador de usuários tradicional
                            }
                    Map<String, dynamic> newUser = {
                      'email': emailController.text,
                      'password': passwordController.text
                    };
                    if (jaCadastrou) {
                      List<dynamic> users = await userManager.readUsers();
                      bool userExists = users.any((user) => user['email'] == newUser['email'] && user['password'] == newUser['password']);
                      if (userExists) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemListView()));
                      } else {
                        print("Usuário não encontrado");
                      }
                    } else {
                      await userManager.writeUser(newUser);
                      print("Usuário cadastrado com sucesso");
                    }
                  }
                },
                child: Text((jaCadastrou) ? "Login" : "Registrar"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    jaCadastrou = !jaCadastrou;
                  });
                },
                child: Text(jaCadastrou ? "Registrar" : "Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}