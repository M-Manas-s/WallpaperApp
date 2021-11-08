import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/LandingPage.dart';
import 'package:wallpaperapp/services/Networking.dart';

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
    getImages();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  Future<dynamic> getImages() async {
    String urlStandard =
        'https://api.unsplash.com/photos?per_page=12&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI';
    String urlFeatured =
        "https://api.unsplash.com/photos/random?per_page=12&count=4&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI";

    List<WallPaper> localList = [];
    List<WallPaper> featured = [];

    var imagedata1 = await NetworkHelper().getWallpaper(urlStandard);
    var imagedata2 = await NetworkHelper().getWallpaper(urlFeatured);

    for (var x in imagedata1) {
      localList.add(WallPaper(blur:  x['blur_hash'],regular:x['urls']['regular'],full: x['urls']['full'], ));

      CachedNetworkImage(
        imageUrl: x['urls']['regular'],
      );
    }
    
    for (var x in imagedata2) {
      featured.add(WallPaper(blur: x['blur_hash'], regular: x['urls']['regular'], full: x['urls']['full']));
      CachedNetworkImage(
        imageUrl: x['urls']['regular'],
      );
    }

    return Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                    preLoadedImages: localList,
                    featuredImages: featured,
                  )),
          (route) => false);
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
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 30,
                              color: Colors.white,
                              fontFamily: 'Horizon'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: DefaultTextStyle(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 30,
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
                            Expanded(
                              child: Container(),
                            )
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
