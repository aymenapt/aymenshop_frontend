
import 'dart:convert';

class Ads {
  final int id ;
  final String image ;

  Ads({required this.image,required this.id});

  factory Ads.fromJson(Map<String,dynamic>jsondata){
    return Ads(id:jsondata['id'] ,image: jsondata['get_image']);
  }
}

  List<Ads> adsFromJson(String str) =>
    List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));