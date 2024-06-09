import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../item.dart';
import 'item_details_view.dart';
import 'register_hamburgueria_screen.dart';

class ItemListView extends StatelessWidget {
  // Altere o nome da coleção para corresponder ao nome da sua coleção no Firestore
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('hamburguerias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: const Text(
          'Hamburguerias', textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterHamburgueriaScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              Item item = Item.fromFirestore(data.docs[index]);
              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                    'Nota: ${item.rating}, Valor: R\$${item.value.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailsView(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
