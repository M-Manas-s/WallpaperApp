import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:wallpaperapp/widgets/circulariconbutton.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Wallpapers'),
        titleTextStyle: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: ImageSlideshow(
                  children: [
                    Image.asset(
                      'images/img1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/img2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/img3.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/img4.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                  isLoop: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularIconButton(onpressed: (){},iconname: 'Top',icon: Icons.mood,color: Colors.purple,),
                  CircularIconButton(onpressed: (){},iconname: 'Collections',icon: Icons.collections_bookmark_outlined,color: Colors.green,),
                  CircularIconButton(onpressed: (){},iconname: 'Nature',icon: Icons.filter_vintage_outlined,color: Colors.red,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text('Best out of all',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                subtitle: Text('Special ones for you',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.chevron_right,color: Colors.white,),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

