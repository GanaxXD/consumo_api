import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

    IconData icon;
    Color splashColor;
    String text;

    MyButton({@required this.icon, @required this.splashColor, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        width: 145,
        height: 80,
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
            ),
            color: Colors.green,
            borderRadius: BorderRadius.circular(60),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    icon: Icon(icon, color: Colors.white,),
                    splashColor: splashColor,

                ),
                Text(text, style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600
                ),)
            ],
        )
    );
  }
}
