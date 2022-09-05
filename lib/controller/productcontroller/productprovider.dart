import 'dart:convert';

import 'package:aymen_shop/models/adsmodels/adsmodels.dart';

import 'package:aymen_shop/models/productsmodels/productmodels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/productitemmodel/productitemmodels.dart';

class ProductProvider with ChangeNotifier {
  //get last 4 products
  Future<List<Product>> getlatestproducts() async {
    final url = Uri.parse("https://aymenshop.herokuapp.com/latestproducts/");
    final res = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var resdata = res.body;
    print(resdata);
    return productFromJson(resdata);
  }

  //search product by name or by category 
  Future<ProductItem>searchproduct(String serchingvalue)async {
  
       final url = Uri.parse("https://aymenshop.herokuapp.com/productitem/$serchingvalue/");
       try{
       final res = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
   var resdata=res.body ;
   print(resdata);
   return productItemFromJson(resdata);
       }catch(error){
        throw 'no product with this name ' ;
       }

       
  }

  //get ads 
  Future<List<Ads>> getAds() async {
    final url = Uri.parse("https://aymenshop.herokuapp.com/ads/");
    final res = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var resdata = res.body;
    print(resdata);
    return adsFromJson(resdata);
  }
  //add review for the products
Future addreview(String review,int productid)async {
       final url = Uri.parse("https://aymenshop.herokuapp.com/comments/");
       final res = await http.post(url,body: json.encode({
        'created_by':1 ,
        'comments':review,
        'product':productid
       }) ,headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
   var resdata=res.body ;
   print(resdata);
  }
  // add rate for product
  Future addrating(double stars,int productid)async {
       final url = Uri.parse("https://aymenshop.herokuapp.com/rating/$productid/");
       final res = await http.post(url,body: json.encode({
        'user':1 ,
        'stars':stars,
        'product':productid
       }) ,headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
   var resdata=res.body ;
   print(resdata);
  }

  //get  all products from the category
 
Future<List<Product>> getcategoryproducts() async {
    final url = Uri.parse("https://aymenshop.herokuapp.com/listofallproducts/");
    final res = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var resdata = res.body;
    print(resdata);
    return productFromJson(resdata);
  }


  //add products to card 
   List<Product>? cardproducts =[];
   cardlist({required Product product}){
    cardproducts!.add(product) ;
    notifyListeners();
   
  }

}
