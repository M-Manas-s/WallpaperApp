import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';
import 'package:wallpaperapp/screens/LikedScreen.dart';
import 'ExplorePage.dart';

// class LocalUserData extends InheritedWidget{
//   final LocalUser localUser = LocalUser();
//
//   LocalUserData({
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   static LocalUserData of(BuildContext context) {
//     final LocalUserData? result = context.dependOnInheritedWidgetOfExactType<LocalUserData>();
//     assert(result != null, 'No FrogColor found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(LocalUserData old) => localUser != old.localUser;
// }

class LandingPage extends StatefulWidget {
  static String id = 'Default_Page';
  final List<WallPaper> preLoadedImages;
  final List<WallPaper> featuredImages;

  const LandingPage(
      {Key? key, required this.preLoadedImages, required this.featuredImages})
      : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalUser>(
      create: (context)=>LocalUser(),
      child: MaterialApp(
        initialRoute: ExplorePage.id,
        routes: {
          ExplorePage.id: (context) => ExplorePage(
                preLoadedImages: widget.preLoadedImages,
                featuredImages: widget.featuredImages,
              ),
          LikedPage.id: (context) => LikedPage(),
        },
      ),
    );
  }
}
