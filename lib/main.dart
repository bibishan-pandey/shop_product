import 'package:flutter/material.dart';
import 'package:shop_product/config/themes/dark_theme.dart';
import 'package:shop_product/config/themes/light_theme.dart';
import 'package:shop_product/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Product',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: ProductOverviewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
