import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:wallpaperapp/constants/LocalUser.dart';
import 'package:wallpaperapp/widgets/circulariconbutton.dart';
import 'itempage.dart';
import 'package:wallpaperapp/services/Networking.dart';

class ExplorePage extends StatefulWidget {
  static String id = 'Explore_Page';
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController _controller = TextEditingController();
  late String searchText;
  var decodeddata;
  List<String> imageList = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg',
    'images/img4.jpg',
  ];

  List<Image> gridimagelist = [];

  @override
  void initState() {
    super.initState();
    print(LocalUser.id);
    getImages(
        'https://api.unsplash.com/photos?per_page=12&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI');
  }

  Future<dynamic> getImages(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url);

    var imagedata = await networkHelper.getWallpaper();
    setState(() {
      decodeddata = imagedata;
    });
    appenddatainList();
  }

  void appenddatainList() {
    for (int i = 0; i < 9; i++) {
      gridimagelist.add(Image.network(
        decodeddata[i]['urls']['regular'],
        fit: BoxFit.cover,
      ));
    }
  }

  void clearText() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Wallpapers'),
        titleTextStyle: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
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
                              icon: Icon(Icons.clear,color: Colors.white,)),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: ImageSlideshow(
                          autoPlayInterval: 1,
                          children: [
                            Image.asset(
                              'images/img1.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'images/img2.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'images/img3.jpg',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'images/img4.jpg',
                              fit: BoxFit.cover,
                            ),
                          ],
                          isLoop: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularIconButton(
                          onpressed: () {},
                          iconname: 'Top',
                          icon: Icon(
                            Icons.mood,
                            color: Colors.white,
                          ),
                          color: Colors.purple,
                        ),
                        CircularIconButton(
                          onpressed: () {},
                          iconname: 'Collections',
                          icon: Icon(
                            Icons.collections_bookmark_outlined,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                        ),
                        CircularIconButton(
                          onpressed: () {},
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
                  WallpaperGridBuilder(gridimagelist: gridimagelist),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WallpaperGridBuilder extends StatelessWidget {
  const WallpaperGridBuilder({
    Key? key,
    required this.gridimagelist,
  }) : super(key: key);

  final List<Image> gridimagelist;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
            child:
                gridimagelist.length == 0 ? Container() : gridimagelist[index],
          ),
        );
      },
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
