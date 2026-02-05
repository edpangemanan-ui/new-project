import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  ProductForm({this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _skuCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  final ProductService _service = ProductService();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _skuCtrl.text = widget.product!.sku;
      _nameCtrl.text = widget.product!.name;
      _qtyCtrl.text = widget.product!.qty.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _skuCtrl, decoration: InputDecoration(labelText: 'SKU')),
              SizedBox(height: 8),
              TextFormField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Name')),
              SizedBox(height: 8),
              Row(children: [
                Expanded(child: TextFormField(controller: _qtyCtrl, decoration: InputDecoration(labelText: 'Qty'), keyboardType: TextInputType.number)),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: () async {
                    final code = await Navigator.push(context, MaterialPageRoute(builder: (_) => BarcodeScannerScreen()));
                    if (code != null) {
                      _skuCtrl.text = code as String;
                    }
                  },
                )
              ]),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    final p = Product(
                      id: widget.product?.id ?? '',
                      sku: _skuCtrl.text.trim(),
                      name: _nameCtrl.text.trim(),
                      qty: int.tryParse(_qtyCtrl.text) ?? 0,
                    );
                    if (widget.product == null) {
                      await _service.addProduct(p);
                    } else {
                      await _service.updateProduct(p);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

class BarcodeScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan barcode')),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          final String? code = barcode.rawValue;
          if (code != null) {
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}
