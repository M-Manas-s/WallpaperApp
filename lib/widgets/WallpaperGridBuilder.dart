import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/itempage.dart';

class WallpaperGridBuilder extends StatelessWidget {
  const WallpaperGridBuilder({
    Key? key,
    required this.gridimagelist,  this.isLiked=false,
  } ) : super(key: key);

  final List<WallPaper> gridimagelist;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return gridimagelist.length == 0
        ? Container()
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            itemCount: gridimagelist.length,
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
                      builder: (_) => ItemPage(Wallpaper: gridimagelist[index],isLiked: isLiked),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: gridimagelist[index].regular,
                    fit: BoxFit.fitHeight,
                    placeholder: (_, __) {
                      return AspectRatio(
                        aspectRatio: 1.6,
                        child: BlurHash(hash: gridimagelist[index].blur,),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}
