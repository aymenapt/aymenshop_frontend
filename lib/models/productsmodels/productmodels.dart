// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.categoryname,
    required this.productimage,
    required this.price,
    required this.comments,
    required this.numRating,
    required this.avgRating,
  });

  final int id;
  final String name;
  final String description;
  final String slug;
  final String categoryname;
  final String productimage;
  final String price;
  final List<dynamic> comments;
  final int numRating;
  final double avgRating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        slug: json["get_absolute_url"],
       categoryname : json["catergoryname"],
        productimage: json["get_image"],
        price:json["price"] ,
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        numRating: json["num_rating"],
        avgRating: json["avg_rating"] ?? 0,
      );
}
