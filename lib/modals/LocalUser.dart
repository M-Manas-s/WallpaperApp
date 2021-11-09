import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpaperapp/modals/WallpaperClass.dart';

class LocalUser {
  static late String id;
  static late String email;
  List<WallPaper> likedImages = [];

  erase() {
    likedImages.clear();
  }

  localAdd(WallPaper wallpaper) {
    likedImages.add(wallpaper);
  }

  addWallpaperToDB(WallPaper wallPaper) {
    return FirebaseFirestore.instance.collection('Users').doc(id).update({
      'LikedURLs': FieldValue.arrayUnion([wallPaper.toMap])
    });
  }

  addWallpaperToLiked(WallPaper wallPaper) {
    if (exists(wallPaper) == false) {
      likedImages.add(wallPaper);
      addWallpaperToDB(wallPaper);
      for (var x in likedImages)
        print(x.regular + '\n');
    } else {
      print('exist');
    }
  }

  get getId {
    return id;
  }

  bool exists(WallPaper wallPaper) {
    for (var x in likedImages)
      if (x.regular == wallPaper.regular) return true;
    return false;
  }

  int indexOf(WallPaper wallPaper) {
    for (int i = 0; i < likedImages.length; i++)
      if (likedImages[i].regular == wallPaper.regular) return i;
    return -1;
  }

  deleteLiked(WallPaper wallPaper) async{
    likedImages.removeAt(indexOf(wallPaper));
    FirebaseFirestore.instance.collection('Users').doc(id).update({
      'LikedURLs': []
    });
    for (var x in likedImages)
      await addWallpaperToDB(x);
  }
}
