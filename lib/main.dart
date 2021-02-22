import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_product/config/themes/dark_theme.dart';
import 'package:shop_product/config/themes/light_theme.dart';
import 'package:shop_product/helpers/dummy_data.dart';
import 'package:shop_product/models/product.dart';
import 'package:shop_product/screens/product_detail_screen.dart';
import 'package:shop_product/screens/products_overview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Product> _products = products;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Product',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: ProductOverviewScreen(
        products: _products,
      ),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
