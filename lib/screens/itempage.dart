import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/services/AppBrain.dart';

class ItemPage extends StatefulWidget {
  final WallPaper wallpaper;

  ItemPage({required this.wallpaper});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int dropdownvalue = 80;

  void getanddownload(int qualtity) async {
    await AppBrain().save(widget.wallpaper.full, qualtity);
  }

  @override
  Widget build(BuildContext context) {
    bool localIsLiked =
        Provider.of<LocalUser>(context, listen: false).exists(widget.wallpaper);
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          Positioned(
            right: 15.0,
            bottom: 170.0,
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  top: 4,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(500))),
                ),
                LikeButton(
                  isLiked: localIsLiked,
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
                      color: isLiked ? Colors.redAccent : Colors.white,
                    );
                  },
                  onTap: (isLiked) async {
                      setState(() {
                        localIsLiked = !localIsLiked;
                      });
                      if (Provider.of<LocalUser>(context, listen: false)
                          .exists(widget.wallpaper)) {
                        await Provider.of<LocalUser>(context, listen: false)
                            .deleteLiked(widget.wallpaper);
                      } else {
                        await Provider.of<LocalUser>(context, listen: false)
                            .addWallpaperToLiked(widget.wallpaper);
                      }
                    return !isLiked;
                  },
                )
              ],
            ),
          ),
          Positioned(
            left: 10.0,
            top: 50.0,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 50.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: MediaQuery.of(context).size.width / 3,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  DropdownButton<int>(
                    alignment: Alignment.center,
                    underline: Container(),
                    iconSize: 0,
                    dropdownColor: Colors.black,
                    value: dropdownvalue,
                    items: [
                      DropdownMenuItem<int>(
                        value: 80,
                        child: Text(
                          'High',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 60,
                        child: Text(
                          'Medium',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 30,
                        child: Text(
                          'Low',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropdownvalue = value!;
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      print("pressed");
                      getanddownload(dropdownvalue);
                    },
                    icon: Icon(
                      Icons.file_download,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
