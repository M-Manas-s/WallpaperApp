import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';

class ItemPage extends StatefulWidget {
  dynamic Wallpaper;
  ItemPage({required this.Wallpaper});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

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
                imageUrl: widget.Wallpaper['full'],
                fit: BoxFit.fitHeight,
                placeholder: (_, __) {
                  return AspectRatio(
                    aspectRatio: 1.6,
                    child: BlurHash(hash: widget.Wallpaper['blur'],),
                  );
                },
              )
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: 170.0,
            child: LikeButton(
              size: 60.0,
              circleColor:
              CircleColor(start: Colors.redAccent, end: Colors.red),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.redAccent,
                dotSecondaryColor: Colors.red,
              ),
              likeBuilder: (bool isLiked) {
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
