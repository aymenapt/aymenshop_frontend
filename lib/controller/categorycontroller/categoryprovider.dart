import 'dart:convert';

import 'package:aymen_shop/models/categorymodels/categorymodels.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  final url = Uri.parse('https://aymenshop.herokuapp.com/listcategory/');
  Future<List<Category>> getcategories() async {
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
     var resdata=res.body ;
      print(resdata);
      return categoryFromJson(resdata);
  }
}
