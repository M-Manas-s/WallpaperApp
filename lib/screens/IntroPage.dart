import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaperapp/widgets/AuthenticationButton.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07,vertical: size.width * 0.07),
                child: Container(
                  decoration: BoxDecoration(
                    color : Color(0xff3B3941),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AuthenticationButton(label: "Register", color: Colors.white, OnPressed : (){}, height: size.height*0.09,)
                      ),
                      Expanded(
                        child: AuthenticationButton(label : "Sign in", color : Color(0xff3B3941), OnPressed: (){}, height: size.height*0.09,),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
