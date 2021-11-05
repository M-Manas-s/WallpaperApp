import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ItemPage extends StatefulWidget {
  Image Wallpaper;
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
              child: widget.Wallpaper
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
