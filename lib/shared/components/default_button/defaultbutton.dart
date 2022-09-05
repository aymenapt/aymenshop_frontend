
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

Widget Defaultbutton({
  required functon,
  Color color = Colors.blue,
  required String text,
  double border = 10.0,
  double fontsize=18 ,
  required double height ,
 required double width ,
 
}) {
  return Container(
    width:width ,
    height: height,
    child: RaisedButton(
      onPressed:functon,
      child: Text(
        text,
        style: TextStyle(
            color: whitecolor, fontSize: fontsize, fontWeight: FontWeight.bold),
      ),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
