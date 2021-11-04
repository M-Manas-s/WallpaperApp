import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {

  final String label;
  final Color color;
  final Function OnPressed;
  final double height;

  const AuthenticationButton({Key? key, required this.label, required this.color, required this.OnPressed, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        style:
        ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: OnPressed(),
        child: Container(
          height: height,
          child: Center(
            child: Text(
              label,
              style:
              TextStyle(fontSize: 18, color: color==Colors.white?Colors.black:Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(80))),
        ));
  }
}

