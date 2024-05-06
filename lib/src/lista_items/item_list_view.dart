import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'item.dart';
import 'item_details_view.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    this.items = const [
      Item(1, "Hamburgueria Viking", 4.2, "*"), 
      Item(2, "Hamburgueria e Sushi Samurai", 2.1, "**"), 
      Item(3, "Hamburgueria e Pizza Cavaleiro", 3.5, "*"),
      Item(4, "Hamburgueria Hussardo", 1.7, "****")
      ]
  });

  static const routeName = '/';

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    const String nomeLista = "Hamburguerias";
    return Scaffold(
      appBar: AppBar(
        title: const Text(nomeLista),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () { // vai para configurações
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 177,34,34),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          const double maximoRating = 5.0;
          final textoItem = """${item.nome}. Avaliação (${item.rating} / $maximoRating). Valor Médio: ${item.valorMedio}""";
          const Color corTexto = Color.fromARGB(255, 70,130,180);
          return ListTile(
            title: Text(textoItem, 
            style: const TextStyle(color : corTexto), 

            )
            ,
            leading: const CircleAvatar( // add icone circular de hamburguer ao lado de cada 
              foregroundImage: AssetImage('assets/images/hamb1.png')
            ),
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                ItemDetailsView.routeName,
              );
            }
          );
        },
      ),
    );
  }
}
