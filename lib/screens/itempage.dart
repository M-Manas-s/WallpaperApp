import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'LandingPage.dart';

class ItemPage extends StatefulWidget {
  WallPaper wallpaper;

  ItemPage({required this.wallpaper});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  late bool localIsLiked;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localIsLiked = LocalUserData.of(context).localUser.exists(widget.wallpaper);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragDown: (value) {},
            child: Container(
                width: MediaQuery.of(context).size.width + 200,
                height: MediaQuery.of(context).size.height,
                child: CachedNetworkImage(
                  imageUrl: widget.wallpaper.full,
                  fit: BoxFit.fitHeight,
                  placeholder: (_, __) {
                    return AspectRatio(
                      aspectRatio: 1.6,
                      child: BlurHash(
                        hash: widget.wallpaper.blur,
                      ),
                    );
                  },
                )),
          ),
          Positioned(
            right: 20.0,
            bottom: 170.0,
            child: LikeButton(
              isLiked: LocalUserData.of(context).localUser.exists(widget.wallpaper),  //Use Inherited widget
              size: 30.0,
              circleColor:
                  CircleColor(start: Colors.redAccent, end: Colors.red),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.redAccent,
                dotSecondaryColor: Colors.red,
              ),
              likeBuilder: (bool isLiked) {
                if (localIsLiked != isLiked) {
                  localIsLiked = isLiked;
                  if (isLiked) {
                    LocalUserData.of(context).localUser.addWallpaperToLiked(widget.wallpaper);
                  } else {
                    LocalUserData.of(context).localUser.deleteLiked(widget.wallpaper);
                  }
                }
                return Icon(
                  Icons.favorite,
                  size: 30.0,
                  color: isLiked ? Colors.redAccent : Colors.grey,
                );
              },
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: MediaQuery.of(context).size.width / 4,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 50.0,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  elevation: MaterialStateProperty.all(5.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Download/Apply',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
