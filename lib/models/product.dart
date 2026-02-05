import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String sku;
  String name;
  String category;
  int qty;
  double costPrice;
  double sellPrice;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    this.category = '',
    this.qty = 0,
    this.costPrice = 0.0,
    this.sellPrice = 0.0,
  });

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      sku: data['sku'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      qty: (data['qty'] ?? 0) as int,
      costPrice: (data['costPrice'] ?? 0.0).toDouble(),
      sellPrice: (data['sellPrice'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'sku': sku,
        'name': name,
        'category': category,
        'qty': qty,
        'costPrice': costPrice,
        'sellPrice': sellPrice,
      };
}
