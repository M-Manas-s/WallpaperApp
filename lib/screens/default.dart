import 'package:flutter/material.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/LikedScreen.dart';
import 'explore.dart';


class DefaultPage extends StatefulWidget {
  static String id = 'Default_Page';
  final List<WallPaper> preLoadedImages;
  final List<WallPaper> featuredImages;

  const DefaultPage(
      {Key? key, required this.preLoadedImages, required this.featuredImages})
      : super(key: key);

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ExplorePage.id,
      routes: {
        ExplorePage.id:(context)=>ExplorePage(preLoadedImages: widget.preLoadedImages,featuredImages: widget.featuredImages,),
        LikedPage.id:(context)=>LikedPage(),
      },
    );
  }
}
