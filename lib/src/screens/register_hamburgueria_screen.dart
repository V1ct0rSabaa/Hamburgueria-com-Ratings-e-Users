import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterHamburgueriaScreen extends StatefulWidget {
  @override
  _RegisterHamburgueriaScreenState createState() => _RegisterHamburgueriaScreenState();
}

class _RegisterHamburgueriaScreenState extends State<RegisterHamburgueriaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final CollectionReference hamburguerias = FirebaseFirestore.instance.collection('hamburguerias');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, String>> _comments = [];

  Future<void> _registerHamburgueria() async {
    if (_formKey.currentState!.validate()) {
      // Verificar se o usuário está autenticado
      if (_auth.currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Você precisa estar autenticado para registrar uma nova hamburgueria.')));
        return;
      }

      // Verificar se já existe uma hamburgueria com o mesmo nome
      QuerySnapshot querySnapshot = await hamburguerias.where('name', isEqualTo: _nameController.text).get();
      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Já existe uma hamburgueria registrada com esse nome.')));
        return;
      }

      // Adicionar a nova hamburgueria ao Firestore
      await hamburguerias.add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'price': double.parse(_priceController.text),
        'rating': double.parse(_ratingController.text),
        'comments': _comments,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hamburgueria registrada com sucesso.')));
      Navigator.pop(context);
    }
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add({
          'user': _auth.currentUser?.email ?? 'Anônimo',
          'comment': _commentController.text,
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Nova Hamburgueria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da hamburgueria.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço.';
                  }
                  return null;
                },
              ),
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
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Nota (0-5)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a nota.';
                  }
                  double? rating = double.tryParse(value);
                  if (rating == null || rating < 0 || rating > 5) {
                    return 'Por favor, insira um valor entre 0 e 5.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Comentários:'),
              ..._comments.map((comment) {
                return ListTile(
                  title: Text(comment['user'] ?? 'Anônimo'),
                  subtitle: Text(comment['comment'] ?? ''),
                );
              }).toList(),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(labelText: 'Adicionar Comentário'),
              ),
              ElevatedButton(
                onPressed: _addComment,
                child: Text('Adicionar Comentário'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerHamburgueria,
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
