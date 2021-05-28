import 'package:consumoapi/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumindo Dados da API',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
