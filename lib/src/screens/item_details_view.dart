import 'package:flutter/material.dart';
import 'package:hamburgueria/src/models/item.dart';

/// Displays detailed information about a SampleItem.
class ItemDetailsView extends StatelessWidget {

  const ItemDetailsView({super.key, required this.item});

  final Item item;
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    const corLT = Colors.black12;
    // final data = "Nome: ${item.nome}\nNota: ${item.nota} / 5\nValor médio dos pratos: ${item.valorMedio}\nNúmero de telefone: ${item.contato}\nEndereço: ${item.endereco}";
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Hamburgueria'), backgroundColor: Colors.red[300],)
      , body: ListView(children: [
        ListTile(title: Text("Nome: ${item.nome}"), tileColor: corLT),
        ListTile(title: Text("Nota: ${item.nota} / 5"), tileColor: corLT),
        ListTile(title: Text("Valor médio dos pratos: ${item.valorMedio}"), tileColor: corLT),
        ListTile(title: Text("Número de Telefone / Whatsapp / Telegram: ${item.contato}"), tileColor: corLT),
        ListTile(title: Text("Endereço: ${item.endereco}"), tileColor: corLT)
        ])
      );
  }
}
