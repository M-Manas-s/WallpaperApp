import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/itempage.dart';

class WallpaperGridBuilder extends StatefulWidget {
  WallpaperGridBuilder({
    Key? key,
    required this.gridimagelist,
    this.mutableList = false,
  }) : super(key: key);

  final List<WallPaper> gridimagelist;
  final bool mutableList;

  @override
  _WallpaperGridBuilderState createState() => _WallpaperGridBuilderState();
}

class _WallpaperGridBuilderState extends State<WallpaperGridBuilder> {
  @override
  Widget build(BuildContext context) {
    final int? mutableLength =
        Provider.of<LocalUser>(context).likedImages.length;

    return widget.gridimagelist.length == 0
        ? Container(
            child: Center(
              child: Text(
                'No Liked Images',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            itemCount: widget.mutableList
                ? mutableLength
                : widget.gridimagelist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 18.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1 / 2),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ItemPage(wallpaper: widget.gridimagelist[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.gridimagelist[index].regular,
                    fit: BoxFit.fitHeight,
                    placeholder: (_, __) {
                      return AspectRatio(
                        aspectRatio: 1.6,
                        child: BlurHash(
                          hash: widget.gridimagelist[index].blur,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}
