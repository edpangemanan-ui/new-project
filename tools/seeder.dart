// Simple Dart script to seed Firestore with example products.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  final col = FirebaseFirestore.instance.collection('products');
  final examples = [
    {'sku': 'SKU-001', 'name': 'Product A', 'qty': 10, 'costPrice': 5.0, 'sellPrice': 10.0},
    {'sku': 'SKU-002', 'name': 'Product B', 'qty': 5, 'costPrice': 7.0, 'sellPrice': 15.0},
  ];
  for (final e in examples) {
    await col.add(e);
    print('Added ${e['sku']}');
  }
  print('Seeding complete');
}
