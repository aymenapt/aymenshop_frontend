// To parse this JSON data, do
//
//     final productItem = productItemFromJson(jsonString);


import 'dart:convert';

ProductItem productItemFromJson(String str) => ProductItem.fromJson(json.decode(str));

class ProductItem {
    ProductItem({
        required this.id,
        required this.name,
        required this.description,
        required this.getAbsoluteUrl,
        required this.getImage,
        required this.price,
        required this.comments,
        required this.numRating,
        required this.avgRating,
    });

    final int id;
    final String name;
    final String description;
    final String getAbsoluteUrl;
    final String getImage;
    final String price;
    final List<Comment> comments;
    final int numRating;
    final double avgRating;

    factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        getAbsoluteUrl: json["get_absolute_url"],
        getImage: json["get_image"],
        price: json["price"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        numRating: json["num_rating"],
        avgRating: json["avg_rating"]??0,
    );

}

class Comment {
    Comment({
        required this.id,
        required this.createdBy,
        required this.comments,
        required this.product,
    });

    final int id;
    final int createdBy;
    final String comments;
    final int product;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        createdBy: json["created_by"],
        comments: json["comments"],
        product: json["product"],
    );

}
