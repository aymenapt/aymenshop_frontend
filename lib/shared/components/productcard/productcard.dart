import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class ProductCard extends StatelessWidget {
  final String productname;
  final String productimage;
  final String price;
  final double rating;
  final int num_rating;

  const ProductCard(
      {Key? key,
      required this.productname,
      required this.productimage,
      required this.price,
      required this.rating,
      required this.num_rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      height: height,
      width: width * 0.5,
      decoration: BoxDecoration(
          color: whitecolor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              width: width,
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Image.network(
                    productimage,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerLeft,
                width: width * 0.2,
                child: Text(
                  productname,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: blackcolor, fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      '$price\$',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '${ double.parse((rating).toStringAsFixed(2))}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.star,
                      color: buttoncolor,
                      size: 16,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
