import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String name;
  final String image;

  const CategoryCard({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  get blackcolor => null;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return 
       Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 18,right: 7),
              height: height * 0.1,
              width: width * 0.2,
              decoration: BoxDecoration(
                  color: blackcolor, borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.image)),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 18),
                  width: width * 0.2,
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: blackcolor, fontWeight: FontWeight.bold),
                  )))
        ],
      );
    
  }
}
