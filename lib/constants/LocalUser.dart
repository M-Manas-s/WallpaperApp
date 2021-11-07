import 'package:wallpaperapp/modals/WallpaperClass.dart';

class LocalUser {
  static late String id;
  static late String email;
  List<WallPaper> likedImages=[];

   addWallpaperToLiked(WallPaper wallPaper){
    if (urlChecker(wallPaper)==false){
      likedImages.add(wallPaper);
      //Add to database as well
      print('Added to List');
    }else{
      print('exist');
    }
  }

   bool urlChecker(WallPaper wallPaper) {
    return likedImages.contains(wallPaper);
  }



   deleteLiked(String lol){
    likedImages.remove(lol);
  }


}