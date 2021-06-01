import 'package:flutter/material.dart';

class MyLinearGradiente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color> [
                    Color.fromRGBO(242, 36, 126, 95),
                    Color.fromRGBO(252, 38, 230, 90),
                    Color.fromRGBO(193, 46, 230, 90),
                    Color.fromRGBO(154, 38, 252, 99),
                    Color.fromRGBO(69, 0, 245, 96),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
            )
        ),
    );
  }
}
