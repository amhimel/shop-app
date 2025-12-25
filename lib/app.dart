import 'package:flutter/material.dart';
import 'package:shop_app/views/ui/mainscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Mainscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
