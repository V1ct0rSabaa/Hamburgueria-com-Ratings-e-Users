import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../item.dart';

class UpdateHamburgueriaScreen extends StatefulWidget {
  final Item item;

  UpdateHamburgueriaScreen({required this.item});

  @override
  _UpdateHamburgueriaScreenState createState() =>
      _UpdateHamburgueriaScreenState();
}

class _UpdateHamburgueriaScreenState extends State<UpdateHamburgueriaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final CollectionReference hamburguerias =
      FirebaseFirestore.instance.collection('hamburguerias');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Preencher o controlador de texto com o nome atual da Hamburgueria
    _nameController.text = widget.item.name;
    _descriptionController.text = widget.item.description;
    _addressController.text = widget.item.address;
    _contactController.text = widget.item.contact;
    _priceController.text = widget.item.value.toStringAsFixed(2);
  }

  Future<void> _updateHamburgueria() async {
    if (_formKey.currentState!.validate()) {
      await hamburguerias.doc(widget.item.id).update({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'price': double.parse(_priceController.text),
      });
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Nome da Hamburgueria atualizado com sucesso.')));
      Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => ItemDetailsView(item: widget.item)),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    const intervalo = SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(title: const Text('Atualizar Nome da Hamburgueria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Por favor, volte para a tela principal após atualizar os dados',
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Novo Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um novo nome para o item.';
                  }
                  return null;
                },
              ),
              intervalo,
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço atualizado.';
                  }
                  return null;
                },
              ),
              intervalo,
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contato'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o contato.';
                  }
                  return null;
                },
              ),
              intervalo,
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço Médio (0-5)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço médio.';
                  }
                  double? price = double.tryParse(value);
                  if (price == null || price < 0 || price > 5) {
                    return 'Por favor, insira um valor entre 0 e 5.';
                  }
                  return null;
                },
              ),
              intervalo,
              ElevatedButton(
                  onPressed: _updateHamburgueria,
                  child: const Text('Atualizar dados da Hamburgueria')),
            ],
          ),
        ),
      ),
    );
  }
}
