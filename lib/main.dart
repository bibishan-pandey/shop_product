import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/config/themes/dark_theme.dart';
import 'package:shop_product/config/themes/light_theme.dart';
import 'package:shop_product/providers/cart_provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/screens/product_detail_screen.dart';
import 'package:shop_product/screens/products_overview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => CartProvider(),
      ),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  static const title = 'Shop Product';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
