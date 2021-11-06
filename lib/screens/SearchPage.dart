import 'package:flutter/material.dart';
import 'package:wallpaperapp/services/Networking.dart';
import 'package:wallpaperapp/widgets/WallpaperGridBuilder.dart';

class SearchPage extends StatefulWidget {
  final String searchItem;
  SearchPage({required this.searchItem});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var decodeddata;
  List<Image> imageList = [];

  Future<dynamic> getCollectionData(String typeOfCollection) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.unsplash.com/search/photos?query=$typeOfCollection&client_id=Hl8nP0CKgfQztU1Y8Wb62YgydLAQSOQCnbnfZ2ueSHI');
    var imagedata = await networkHelper.getWallpaper();
    setState(() {
      decodeddata = imagedata;
    });
    appenddatainList();
  }

  void appenddatainList() {
    for (int i = 0; i < 9; i++) {
      setState(() {
        imageList.add(
          Image.network(
            decodeddata['results'][i]['urls']['regular'],
            fit: BoxFit.cover,
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCollectionData(widget.searchItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                WallpaperGridBuilder(gridimagelist: imageList),
              ],
            ),
          )
        ],
      ),
    );
  }
}
