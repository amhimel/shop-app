import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app.dart';
import 'package:shop_app/controllers/main_screen_notifier_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifierProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
