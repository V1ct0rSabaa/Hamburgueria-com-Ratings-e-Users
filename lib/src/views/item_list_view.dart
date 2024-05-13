import 'package:flutter/material.dart';
import '../settings/settings_view.dart';
import '../models/item.dart';
import 'item_details_view.dart';

class ItemListView extends StatelessWidget {
    static const lista = [
      Item(id: 1,
        nome: "Viking Burguer",
        nota:  2.1,
        valorMedio:  "**",
        endereco:  "Rua das Válquirias, 1876",
        contato:  "42462098"),
      Item(id: 2,
        nome: "Cavaleiro Burguer e Pizza",
        nota:  3.5,
        valorMedio:  "**",
        endereco:  "Rua dos padeiros, 221b",
        contato:  "37037436"),
      Item(id: 3,
        nome: "Samurai Burguer e Sushi",
        nota:  2.1,
        valorMedio:  "**",
        endereco:  "Rua Djavan Viera, 450",
        contato:  "18793090"),
      Item(id: 4,
        nome:  "Hussardo Burguer",
        nota:  1.7,
        valorMedio:  "****",
        endereco:  "Travessa Kowalski 1830",
        contato:  "31128354")
  ];    
  // json.decode("mock.json")["mockHamburguerias";] as List<Map<String, dynamic>>.map((elemento) => Item.fromMap(elemento)) as List<Item>;
  const ItemListView({ super.key, this.items = lista });

  static const routeName = '/lista';

  final List<Item> items;

  ListView buildLista(){
    return ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final itemAtual = items[index];
          const double maxRating = 5.0;
          final textoItem = """${itemAtual.nome}. Avaliação (${itemAtual.nota} / $maxRating). Valor Médio: ${itemAtual.valorMedio}""";
          const Color corTexto = Color.fromARGB(255, 70,130,180);
          return ListTile(
            title: Card.filled(shape: const RoundedRectangleBorder(),
              child: Text(textoItem, style: const TextStyle(color : corTexto, fontSize: 16)),
              )
            ,leading: const CircleAvatar( // add icone circular de hamburguer ao lado de cada 
              foregroundImage: AssetImage('assets/images/hamb1.png')
            ),
            onTap: () {
              // Navigator.restorablePushNamed(context, ItemDetailsView.routeName, item);
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ItemDetailsView(item: itemAtual)));
            }
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    const nomeLista = "Hamburguerias";
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
