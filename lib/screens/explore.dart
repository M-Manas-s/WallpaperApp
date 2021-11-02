import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ExplorePage extends StatefulWidget {
  static String id = 'Explore_Page';
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
        titleTextStyle: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: ImageSlideshow(
                children: [
                  Image.asset('images/img1.jpg',fit: BoxFit.cover,),
                  Image.asset('images/img2.jpg',fit: BoxFit.cover,),
                  Image.asset('images/img3.jpg',fit: BoxFit.cover,),
                  Image.asset('images/img4.jpg',fit: BoxFit.cover,),
                ],
                isLoop: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
