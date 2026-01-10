import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app.dart';
import 'package:shop_app/controllers/cart_provider.dart';
import 'package:shop_app/controllers/favorites_provider.dart';
import 'package:shop_app/controllers/main_screen_notifier_provider.dart';
import 'package:shop_app/controllers/product_page_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("cart_box");
  await Hive.openBox("fav_box");
  runApp(
    //method that initialize app
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifierProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProductNotifierProvider()),
        ChangeNotifierProvider(
          create: (context) => FavoritesProviderNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => CartProviderNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
