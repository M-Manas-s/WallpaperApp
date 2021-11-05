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
    return Future.delayed(Duration(milliseconds: 6000), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder : (context)=>ExplorePage()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Stack(
          children: [
            Center(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: size.width * 0.05),
                        child: Text(
                          'Loading',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).textScaleFactor*30,
                              color: Colors.white,
                              fontFamily: 'Horizon'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: DefaultTextStyle(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor*30,
                          fontFamily: 'Horizon',
                        ),
                        child: Row(
                          children: [
                            AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(milliseconds: 0),
                              animatedTexts: elements
                                  .map((e) => RotateAnimatedText(e,
                                      duration: Duration(milliseconds: 700)))
                                  .toList(),
                            ),
                            Expanded(child: Container(),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset("anim/musicwave.json", width: size.width))
          ],
        )));
  }
}
