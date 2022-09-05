import 'package:flutter/material.dart';

Widget buildImage(String urlImage,int index){
  return Container(
    width: double.infinity,
child: ClipRRect(
  borderRadius: BorderRadius.circular(18),
  child: Image.network(urlImage,fit: BoxFit.cover,)),

  );
}