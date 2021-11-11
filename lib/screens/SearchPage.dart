import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/services/Networking.dart';
import 'package:wallpaperapp/widgets/WallpaperGridBuilder.dart';

class SearchPage extends StatefulWidget {
  final String searchItem;

  SearchPage({required this.searchItem});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<WallPaper> imageList = [];
  int loadedPages=1;
  bool loading = false;
  ScrollController _scrollController = ScrollController();

  Future<dynamic> getCollectionData(String typeOfCollection) async {
    var imagedata = await NetworkHelper().getWallpaper(
        'https://api.unsplash.com/search/photos?per_page=9&query=$typeOfCollection&page=${loadedPages++}&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI');
    appenddatainList(imagedata);
    return Future.delayed(Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(() async {
      if ( _scrollController.position.pixels == _scrollController.position.maxScrollExtent && !loading )
      {
        print("Calling new data");
        setState(() {
          loading = true;
        });
        await getImages();
        setState(() {
          loading = false;
        });
      }
    });
  }

  getImages() async {

    String urlStandard =
        'https://api.unsplash.com/search/photos?per_page=9&query=${widget.searchItem}&page=${loadedPages++}&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI';
    var imagedata1 = await NetworkHelper().getWallpaper(urlStandard);
    for (var x in imagedata1['results']) {
      imageList.add(WallPaper(
        blur: x['blur_hash'],
        regular: x['urls']['regular'],
        full: x['urls']['full'],
      ));
      CachedNetworkImage(
        imageUrl: x['urls']['regular'],
      );
    }
  }


  void appenddatainList(var decodeddata) {
    for (var x in decodeddata['results']) {
      setState(() {
        imageList.add(
          WallPaper(
            blur: x['blur_hash'],
            regular: x['urls']['regular'],
            full: x['urls']['full'],
          ),
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          future: getCollectionData(widget.searchItem),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          WallpaperGridBuilder(gridimagelist: imageList, loading: loading,),
                        ],
                      ),
                    )
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
