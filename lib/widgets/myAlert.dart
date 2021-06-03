import 'package:flutter/material.dart';

class MyAlert extends StatelessWidget {

    final String title, content;

    MyAlert({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
        elevation: 20,
        buttonPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(10),
        content: Text(content),
        contentTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16),
        actions: [
            Center(
                child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(60)
                    ),
                    child: OutlinedButton(
                        onPressed: Navigator.of(context).pop,
                        child: Text("Fechar"),
                    ),
                )
            )
        ],
    );
  }
}
