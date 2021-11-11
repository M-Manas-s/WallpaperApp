import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';

class AppBrain {
  Future save(String url,int quality) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: quality,
        name: "Image${DateTime.now().millisecondsSinceEpoch}");
    print(result);
  }

  // Future requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();
  //   final info = statuses[Permission.storage].toString();
  //   print(info);
  // }
}
