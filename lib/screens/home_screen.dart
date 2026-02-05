import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'product_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async => await auth.signOut(),
          )
        ],
      ),
      body: ProductList(),
    );
  }
}