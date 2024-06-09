import 'package:flutter/material.dart';
import 'package:hamburgueria/src/screens/update_hamburgueria_screen.dart';
import '../item.dart';

class ItemDetailsView extends StatelessWidget {
  final Item item;

  ItemDetailsView({required this.item});

  @override
  Widget build(BuildContext context) {
    const intervaloTexto = SizedBox(height: 10);
    const estiloTexto = TextStyle(fontSize: 20,);
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           ElevatedButton(
            child: const Text('atualizar dados da Hamburgueria'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateHamburgueriaScreen(item: item)),
                );
              },  
            ),
            Text('Nome: ${item.name}', style: estiloTexto),
            intervaloTexto,
            Text('Descrição: ${item.description}', style: estiloTexto),
            intervaloTexto,
            Text('Endereço: ${item.address}', style: estiloTexto),
            intervaloTexto,
            Text('Contato: ${item.contact}', style: estiloTexto),
            intervaloTexto,
            Text('Nota: ${item.rating}', style: estiloTexto),
            intervaloTexto,
            Text('Preço Médio: R\$${item.value.toStringAsFixed(2)}', style: estiloTexto),
            intervaloTexto,
            const Text('Comentários:', style: estiloTexto),
            ...item.comments.map((comment) {
              return ListTile(
                title: Text(comment['user'] ?? 'Anônimo'),
                subtitle: Text(comment['comment'] ?? ''),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
