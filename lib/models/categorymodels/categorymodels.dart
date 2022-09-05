import 'package:flutter/foundation.dart';
import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String slug;
  final String image;

  Category(
      {required this.id,
      required this.name,
      required this.slug,
      required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        slug: json['get_absolute_url'],
        image: json['get_image']);
  }
}

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));
