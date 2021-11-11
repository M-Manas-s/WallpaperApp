import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/itempage.dart';

class WallpaperGridBuilder extends StatefulWidget {
  WallpaperGridBuilder(
      {Key? key, required this.gridimagelist, this.loading = false})
      : super(key: key);

  final List<WallPaper> gridimagelist;
  final bool loading;

  // final int mutableLength;

  @override
  _WallpaperGridBuilderState createState() => _WallpaperGridBuilderState();
}

class _WallpaperGridBuilderState extends State<WallpaperGridBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.gridimagelist.length == 0
        ? Container(
            child: Center(
              child: Text(
                'No Images',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:  MediaQuery.of(context).size.width*(widget.loading?0.2:0)),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  itemCount: widget.gridimagelist.length,
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
                ),
              ),
              widget.loading ? Positioned(bottom: 0, left : MediaQuery.of(context).size.width*0.45,child:Padding(padding: EdgeInsets.only(bottom:  MediaQuery.of(context).size.width*0.05),
              child: CircularProgressIndicator())):Container()
            ],
          );
  }
}
