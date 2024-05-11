import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../models/item.dart';
import 'item_details_view.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    this.items = const [
      Item(id: 1, 
          nome:  "Viking Burguer",
          nota: 4.2, 
          valorMedio:  "*", 
          endereco:  "", 
          contato: ""), 
      Item(id: 2,
        nome: "Samurai Burguer e e Sushi",
        nota:  2.1,
        valorMedio:  "**",
        endereco:  "",
        contato:  ""), 
      Item(id: 3,
        nome: "Cavaleiro Burguer e Pizza",
        nota:  3.5,
        valorMedio:  "*",
        endereco:  "baker street 221b",
        contato:  ""),
      Item(id: 4,
        nome:  "Hussardo Burguer",
        nota:  1.7,
        valorMedio:  "****",
        endereco:  "",
        contato:  "")
      ]
  });

  static const routeName = '/lista';

  final List<Item> items;

  ListView buildLista(){
    return ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          const double maximoRating = 5.0;
          final textoItem = """${item.nome}. Avaliação (${item.nota} / $maximoRating). Valor Médio: ${item.valorMedio}""";
          const Color corTexto = Color.fromARGB(255, 70,130,180);
          return ListTile(
            title: Card.filled(shape: const RoundedRectangleBorder(),
              child: Text(textoItem, style: const TextStyle(color : corTexto, fontSize: 16)),
              )
            ,leading: const CircleAvatar( // add icone circular de hamburguer ao lado de cada 
              foregroundImage: AssetImage('assets/images/hamb1.png')
            ),
            onTap: () {
              Navigator.restorablePushNamed(context,ItemDetailsView.routeName,);
            }
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    const String nomeLista = "Hamburguerias";
    return Scaffold(
        appBar: AppBar(
        title: const Text(nomeLista),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () { Navigator.restorablePushNamed(context, SettingsView.routeName); }
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 177,34,34)
        ),
        body: buildLista()
      );
    }
}
