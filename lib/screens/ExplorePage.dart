import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/LikedScreen.dart';
import 'package:wallpaperapp/widgets/circulariconbutton.dart';
import 'package:wallpaperapp/widgets/WallpaperGridBuilder.dart';
import 'SearchPage.dart';

class ExplorePage extends StatefulWidget {
  static String id = 'Explore_Page';
  final List<WallPaper> preLoadedImages;
  final List<WallPaper> featuredImages;

  const ExplorePage(
      {Key? key, required this.preLoadedImages, required this.featuredImages})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController _controller = TextEditingController();
  List<CachedNetworkImage> featured = [];
  late String searchText;
  var decodeddata;
  int floaded = 0;

  @override
  void initState() {
    widget.featuredImages.forEach((element) {
      featured.add(CachedNetworkImage(
        imageUrl: element.regular,
        fit: BoxFit.fitWidth,
        placeholder: (_, __) {
          return AspectRatio(
            aspectRatio: 1.6,
            child: BlurHash(
              hash: element.blur,
            ),
          );
        },
      ));
    });
    super.initState();
  }

  void clearText() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, LikedPage.id);
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.favorite_border,color: Colors.white,size: 28.0,),
        tooltip: 'Go to Liked Page',
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Wallpapers'),
        titleTextStyle: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            title: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        searchText = value;
                        clearText();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(searchItem: searchText),
                          ),
                        );
                      },
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        hintText: 'Search Eg. London, Food, etc',
                        hintStyle: TextStyle(color: Colors.white60),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            clearText();
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.black,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: Colors.white, width: 1.5)),
                    // borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ImageSlideshow(
                    autoPlayInterval: 3000,
                    children: featured,
                    isLoop: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularIconButton(
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(searchItem: 'Pets'),
                            ),
                          );
                        },
                        iconname: 'Pets',
                        icon: Icon(
                          Icons.pets,
                          color: Colors.white,
                        ),
                        color: Colors.purple,
                      ),
                      CircularIconButton(
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(searchItem: 'Dark'),
                            ),
                          );
                        },
                        iconname: 'Dark',
                        icon: Icon(
                          Icons.nights_stay_outlined,
                          color: Colors.white,
                        ),
                        color: Colors.red,
                      ),
                      CircularIconButton(
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(searchItem: 'Nature'),
                            ),
                          );
                        },
                        iconname: 'Nature',
                        icon: Icon(
                          Icons.filter_vintage_outlined,
                          color: Colors.white,
                        ),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                TitleTile(
                  title: 'Best out of all',
                  subtitle: 'Special ones for you',
                ),
                WallpaperGridBuilder(gridimagelist: widget.preLoadedImages),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TitleTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleTile({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
