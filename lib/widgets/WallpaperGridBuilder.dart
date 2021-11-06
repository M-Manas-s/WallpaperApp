import 'package:flutter/material.dart';
import 'package:wallpaperapp/screens/itempage.dart';

class WallpaperGridBuilder extends StatelessWidget {
  const WallpaperGridBuilder({
    Key? key,
    required this.gridimagelist,
  }) : super(key: key);

  final List<Image> gridimagelist;

  @override
  Widget build(BuildContext context) {
    return gridimagelist.length == 0
        ? Container()
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            itemCount: 9,
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
                      builder: (_) => ItemPage(Wallpaper: gridimagelist[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: gridimagelist[index],
                ),
              );
            },
          );
  }
}
