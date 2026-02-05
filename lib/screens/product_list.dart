import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product.dart';
import 'product_form.dart';
import '../widgets/product_tile.dart';

class ProductList extends StatelessWidget {
  final ProductService _service = ProductService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: _service.streamProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        final products = snapshot.data ?? [];
        return Scaffold(
          body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => ProductTile(product: products[i]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductForm())),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
