import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{

  Future getWallpaper(String url) async{
    var response= await http.get(Uri.parse(url));

    if (response.statusCode==200){
      var decodeddata= json.decode(response.body);
      return decodeddata;
    }else{
      print(response.statusCode);
      return Null;
    }
  }


}