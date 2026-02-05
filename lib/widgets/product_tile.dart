import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_form.dart';
import '../services/product_service.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final ProductService _service = ProductService();
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('SKU: ${product.sku} • Qty: ${product.qty}'),
      trailing: PopupMenuButton<String>(
        onSelected: (v) async {
          if (v == 'edit') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProductForm(product: product)));
          } else if (v == 'delete') {
            await _service.deleteProduct(product.id);
          } else if (v == 'in') {
            await _service.adjustStock(product.id, 1);
          } else if (v == 'out') {
            await _service.adjustStock(product.id, -1);
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(value: 'in', child: Text('Stock +1')),
          PopupMenuItem(value: 'out', child: Text('Stock -1')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
