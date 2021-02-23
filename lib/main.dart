import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/config/themes/dark_theme.dart';
import 'package:shop_product/config/themes/light_theme.dart';
import 'package:shop_product/providers/cart_provider.dart';
import 'package:shop_product/providers/order_provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/screens/cart_overview_screen.dart';
import 'package:shop_product/screens/order_overview_screen.dart';
import 'package:shop_product/screens/product_detail_screen.dart';
import 'package:shop_product/screens/products_overview_screen.dart';
import 'package:shop_product/screens/user_product_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => OrderProvider(),
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
        CartOverviewScreen.routeName: (ctx) => CartOverviewScreen(),
        OrderOverviewScreen.routeName: (ctx) => OrderOverviewScreen(),
        UserProductScreen.routeName: (ctx) => UserProductScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
