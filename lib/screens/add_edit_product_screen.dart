import 'package:flutter/material.dart';

class AddEditProductScreen extends StatefulWidget {
  static const routeName = '/add-edit-product';

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        centerTitle: false,
      ),
      body: Center(
        child: Text('Add or Edit Product'),
      ),
    );
  }
}
