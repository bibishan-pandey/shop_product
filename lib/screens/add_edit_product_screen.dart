import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/models/product.dart';
import 'package:shop_product/providers/product_provider.dart';

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
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
    isFavorite: false,
  );

  bool _isInit = true;

  Map<String, String> _initValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  // loading product if id is provided as route argument
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _product = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'id': _product.id,
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toString(),
          'imageUrl': '',
          // 'imageUrl': _product.imageUrl,
        };
        _imageUrlController.text = _product.imageUrl;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
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
    if (_form.currentState.validate()) {
      _form.currentState.save();
      if (_product.id != null) {
        Provider.of<ProductProvider>(context, listen: false)
            .update(_product.id, _product);
      } else {
        Provider.of<ProductProvider>(context, listen: false).add(_product);
      }
      Navigator.of(context).pop();
    }
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
              initialValue: _initValues['title'],
              decoration: InputDecoration(
                labelText: 'Title',
                errorStyle: TextStyle(color: Theme.of(context).errorColor),
              ),
              textInputAction: TextInputAction.next,
              autofocus: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field is required!';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: newValue,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: _product.imageUrl,
                  isFavorite: _product.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(
                labelText: 'Price',
                errorStyle: TextStyle(color: Theme.of(context).errorColor),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              focusNode: _priceFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field is required!';
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid Price!';
                }
                if (double.parse(value) <= 0.0) {
                  return 'Price should be greater than 0!';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  description: _product.description,
                  price: double.parse(newValue),
                  imageUrl: _product.imageUrl,
                  isFavorite: _product.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(
                labelText: 'Description',
                errorStyle: TextStyle(color: Theme.of(context).errorColor),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field is required!';
                }
                if (value.length < 10) {
                  return 'Must be greater than 10 characters!';
                }
                return null;
              },
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  description: newValue,
                  price: _product.price,
                  imageUrl: _product.imageUrl,
                  isFavorite: _product.isFavorite,
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
                    // initialValue: _initValues['imageUrl'],
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                      errorStyle:
                          TextStyle(color: Theme.of(context).errorColor),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field is required!';
                      }
                      if (!value.startsWith('http')) {
                        return 'Url must start with http or https';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (newValue) {
                      _product = Product(
                        id: _product.id,
                        title: _product.title,
                        description: _product.description,
                        price: _product.price,
                        imageUrl: newValue,
                        isFavorite: _product.isFavorite,
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
