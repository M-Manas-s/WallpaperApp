import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';

class ItemPage extends StatefulWidget {
  WallPaper Wallpaper;
  bool isLiked;

  ItemPage({required this.Wallpaper, required this.isLiked});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // Future<bool> onLikeButtonTapped(bool value) async{
  //   /// send your request here
  //   // final bool success= await sendRequest();
  //
  //   /// if failed, you can do nothing
  //   // return success? !isLiked:isLiked;
  //
  //   setState(() {
  //     widget.isLiked= !widget.isLiked;
  //   });
  //   Provider.of<LocalUser>(context,listen: false).addWallpaperToLiked(widget.Wallpaper['regular']);
  //   return null;
  // }

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
                  imageUrl: widget.Wallpaper.full,
                  fit: BoxFit.fitHeight,
                  placeholder: (_, __) {
                    return AspectRatio(
                      aspectRatio: 1.6,
                      child: BlurHash(
                        hash: widget.Wallpaper.blur,
                      ),
                    );
                  },
                )),
          ),
          Positioned(
            right: 100.0,
            bottom: 170.0,
            child: LikeButton(
              // onTap: onLikeButtonTapped,
              // isLiked: user.urlChecker(widget.Wallpaper),  //Use Inherited widget
              size: 30.0,
              circleColor:
                  CircleColor(start: Colors.redAccent, end: Colors.red),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.redAccent,
                dotSecondaryColor: Colors.red,
              ),
              likeBuilder: (bool isLiked) {
                if (widget.isLiked != isLiked) {
                  widget.isLiked = isLiked;
                  if (isLiked) {

                    // if liked is pressed

                    // FirebaseFirestore.instance
                    //     .collection('Users')
                    //     .doc(LocalUser.id)
                    //     .update({
                    //   "LikedURLs": {'abc': widget.Wallpaper.full}
                    // });
                  } else {

                    // if unliked (like pressed when it was liked)

                    // FirebaseFirestore.instance
                    //     .collection('Users')
                    //     .doc(LocalUser.id)
                    //     .update({
                    //   "LikedURLs": {'abc': 'null'}
                    // });
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
