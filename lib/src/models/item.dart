import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  String description;
  String address;
  String contact;
  double rating;
  double value;
  List<Map<String, dynamic>> comments;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.contact,
    required this.rating,
    required this.value,
    required this.comments,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      name: data['name'] ?? 'No name',
      description: data['description'] ?? 'No description',
      address: data['address'] ?? 'No address',
      contact: data['contact'] ?? 'No contact',
      rating: data['rating']?.toDouble() ?? 0.0,
      value: data['price']?.toDouble() ?? 0.0,
      comments: List<Map<String, dynamic>>.from(data['comments'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'contact': contact,
      'rating': rating,
      'price': value,
      'comments': comments,
    };
  }
}
