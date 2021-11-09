import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/widgets/WallpaperGridBuilder.dart';
import 'LandingPage.dart';

class LikedPage extends StatefulWidget {
  static String id = 'Liked_Page';

  const LikedPage({Key? key}) : super(key: key);

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  Future<String>? updateList() {
    String id = LocalUserData.of(context).localUser.getId;
    LocalUserData.of(context).localUser.erase();
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      for (var x in documentSnapshot['LikedURLs'])
        LocalUserData.of(context).localUser.localAdd(
            WallPaper(regular: x['regular'], full: x['full'], blur: x['blur']));
      print(
          "Received ${LocalUserData.of(context).localUser.likedImages.length} liked images");
      return "Ok";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Liked Wallpapers'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: updateList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: WallpaperGridBuilder(
                  gridimagelist:
                      LocalUserData.of(context).localUser.likedImages,
                  mutableList: true,
                  mutableLength:
                      LocalUserData.of(context).localUser.likedImages.length,
                ),
              );
          }
        },
      ),
    );
  }
}
