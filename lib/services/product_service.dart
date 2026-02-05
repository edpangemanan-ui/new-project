import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> streamProducts() {
    return productsCollection.snapshots().map((snap) => snap.docs.map((d) => Product.fromDoc(d)).toList());
  }

  Future<void> addProduct(Product p) async {
    await productsCollection.add(p.toMap());
  }

  Future<void> updateProduct(Product p) async {
    await productsCollection.doc(p.id).update(p.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await productsCollection.doc(id).delete();
  }

  Future<void> adjustStock(String id, int delta) async {
    await productsCollection.doc(id).update({'qty': FieldValue.increment(delta)});
  }
}
