import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  final String url;
  NetworkHelper(this.url);

  Future getWallpaper() async{
    var response= await http.get(Uri.parse(url));

    if (response.statusCode==200){
      List decodeddata= json.decode(response.body);
      return decodeddata;
    }else{
      print(response.statusCode);
    }
  }


}