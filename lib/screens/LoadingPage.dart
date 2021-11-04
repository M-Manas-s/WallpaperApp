import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaperapp/constants/LocalUser.dart';
import 'package:wallpaperapp/screens/explore.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late AudioPlayer player;
  List<String> elements = [
    "Colors",
    "Pixels",
    "Valley",
    "Sketch",
    "Canvas",
    "Photos",
    "Parrot",
    "Paints",
    "Nature",
    "Oceans"
  ];

  startPlayer() async {
    await player.setLoopMode(LoopMode.one);
    await player.setAsset('audio/bk.m4a');
    player.play();
  }

  initializeUser() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: LocalUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        LocalUser.id = element.id;
      });
    });
    print("Email ${LocalUser.email} has id ${LocalUser.id}");
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    initializeUser();
    startPlayer();
    _fetchImagesAPI();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

   Future<dynamic> _fetchImagesAPI() {
      return Future.delayed(Duration(
        milliseconds: 6000
      ), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder : (context)=>ExplorePage()), (route) => false);
      });
   }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(size.width * 0.12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Text(
                            'Loading',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                                fontFamily: 'Horizon'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DefaultTextStyle(
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontFamily: 'Horizon',
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: Duration(milliseconds: 0),
                            animatedTexts: elements
                                .map((e) =>
                                RotateAnimatedText(e,
                                    duration:
                                    Duration(milliseconds: 700)))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: size.height * 0.5,
                  margin: EdgeInsets.only(top: size.height * 0.5),
                  //color: Colors.red,
                  child: Lottie.asset("anim/musicwave.json"))
            ],
          )
        ));
  }
}
