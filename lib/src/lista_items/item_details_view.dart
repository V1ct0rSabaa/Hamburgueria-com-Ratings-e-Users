import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    const data = "Nome: \nRating: x / 5\nvalor médio dos pratos: ";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: const Center(
        child: Text(data),
      ),
    );
  }
}
