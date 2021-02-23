import 'package:flutter/material.dart';
import 'package:shop_product/models/product.dart';

class AddEditProductScreen extends StatefulWidget {
  static const routeName = '/add-edit-product';

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  Product _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    print(_product.title);
    print(_product.price);
    print(_product.description);
    print(_product.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        centerTitle: false,
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
              autofocus: true,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (newValue) {
                _product = Product(
                  id: null,
                  title: newValue,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: _product.imageUrl,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              focusNode: _priceFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (newValue) {
                _product = Product(
                  id: null,
                  title: _product.title,
                  description: _product.description,
                  price: double.parse(newValue),
                  imageUrl: _product.imageUrl,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              onSaved: (newValue) {
                _product = Product(
                  id: null,
                  title: _product.title,
                  description: newValue,
                  price: _product.price,
                  imageUrl: _product.imageUrl,
                );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(right: 10, top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Text('')
                      : Image.network(
                          _imageUrlController.text,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (ctx, child, loadingProgress) {
                            return loadingProgress == null
                                ? child
                                : LinearProgressIndicator();
                          },
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (newValue) {
                      _product = Product(
                        id: null,
                        title: _product.title,
                        description: _product.description,
                        price: _product.price,
                        imageUrl: newValue,
                      );
                    },
                    // onEditingComplete: () {
                    //   setState(() {});
                    // },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: RaisedButton(
                color: Theme.of(context).buttonTheme.colorScheme.primaryVariant,
                textColor: Colors.white,
                child: Text('Save Product'),
                onPressed: _saveForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
