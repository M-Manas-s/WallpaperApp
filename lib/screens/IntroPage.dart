import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  Widget buildButton(String label, Color color, Function onPressed)
  {
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
        onPressed: onPressed(),
        child: Container(
          height: size.height*0.09,
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Lottie.asset("anim/complexphone.json", width: size.width),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  "Discover amazing wallpapers.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Text(
                      "Decorate your device with beautiful wallpapers. Get access to thousands of trending wallpapers from the Unsplash community.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                )
              ]),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07,vertical: size.height*0.03),
                child: Container(
                  decoration: BoxDecoration(
                    color : Color(0xff3B3941),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: buildButton("Register", Colors.white,(){})
                      ),
                      Expanded(
                        child: buildButton("Sign in", Color(0xff3B3941),(){}))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
