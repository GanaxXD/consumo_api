import 'package:consumoapi/screens/listClient.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumindo Dados da API',

      /*
      Para modificar a cor padrão do Scaffold, eu modifiquei
      a ThemeData do app geral. Dessa forma eu não vou precisar
      mudar o scarffold de cada tela.
       */
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        buttonColor: Colors.white
      ),
      //listClient
      home: HomePage(), //listClient.dart
      debugShowCheckedModeBanner: false,
    );
  }
}
