import 'package:flutter/material.dart';
import '/src/models/item.dart';

class ItemDetailsView extends StatelessWidget {
  final Item item;

  ItemDetailsView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${item.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Descrição: ${item.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Endereço: ${item.address}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Contato: ${item.contact}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Nota: ${item.rating}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Preço Médio: R\$${item.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Comentários:', style: TextStyle(fontSize: 16)),
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
