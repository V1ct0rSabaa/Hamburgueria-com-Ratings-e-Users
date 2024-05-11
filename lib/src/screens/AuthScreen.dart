import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen>{
  bool jaCadastrou = true;
  final Color? corTextoEspecial = Colors.blue[700];

  String? validarEmail(String? entrada){ 
    return null;
  }
  String? validarSenha(String? entrada){ 
    return null;
  }
  String? validarUsername(String? entrada){ 
    return null;
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              showCursor: true,
              decoration: const InputDecoration(label: Text("email")),
              validator: (String? value){
                if(value == null) { return "O email não pode estar vázio!"; }  
                if(!value.contains("@")){ return  "O email deve conter \"@\""; }
                if(value.startsWith("@") || value.endsWith("@") || value.length <= 4) {return "Formato de email inválido"; }
                return null;
              }
            ),
            TextFormField(
              showCursor: true, obscureText: true,
             decoration: const InputDecoration(label: Text("senha")),
             validator: (String? value) {
              if(value == null) { return "A senha não pode estar vázia"; }
              // final regex = RegExp(r"[A-za-z0-9]+");
              // if(regex.hasMatch(value)){
              //   return "Formato de senha inválido, deve conter letras minusculas, maiusculas e números";
              // }
              return null;
             }
            ),
            Visibility(
              visible: jaCadastrou,
              child: TextFormField(decoration: const InputDecoration(label: Text("username"))
              )
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: (){

              },  
              child: Text((jaCadastrou) ? "Fazer Login" : "Criar Conta", style: TextStyle(fontSize: 15, color: corTextoEspecial))
            ),
            const Divider(),
            TextButton(
              onPressed: (){ setState(() {
                jaCadastrou = !jaCadastrou; })
              ;},
              child: Text((jaCadastrou) ? "Ainda não tem uma conta? Cadastre-se!" : "Já tenho conta, quero fazer login.", 
                style: TextStyle(fontSize: 15, color: corTextoEspecial))
                )
            ]
          )
        )
      )
    );
  }
}

  
