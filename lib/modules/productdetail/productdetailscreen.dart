import 'package:aymen_shop/controller/productcontroller/productprovider.dart';
import 'package:aymen_shop/models/productsmodels/productmodels.dart';
import 'package:aymen_shop/shared/components/default_button/defaultbutton.dart';
import 'package:aymen_shop/shared/components/toast/toast.dart';
import 'package:aymen_shop/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productid;
  final String productname;
  final String productimage;
  final String description;
  final String price;
  final double rating;
  final int num_rating;
  final List<dynamic> comments;
  final Product product ;

  const ProductDetailScreen(
      {Key? key,
      required this.productid,
      required this.productname,
      required this.productimage,
      required this.description,
      required this.price,
      required this.rating,
      required this.num_rating,
      required this.comments,
      required this.product
      })
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController review = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  double myrating = 0.0;

  Widget addrating() {
    return RatingBar.builder(
      itemBuilder: ((context, index) => Icon(
            Icons.star,
            color: textColor,
          )),
      onRatingUpdate: (rating) {
        setState(() {
          myrating = rating;
        });
      },
      allowHalfRating: true,
      itemCount: 5,
      initialRating: 0.5,
      updateOnDrag: true,
    );
  }

  raitingdialogue() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: (() {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addrating(myrating, widget.productid);
                      Navigator.of(context).pop();
                    }),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: textColor),
                    ))
              ],
              title: const Text(
                'add your rating',
                style: TextStyle(color: blackcolor),
              ),
              content: addrating(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: shopbackgroungColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: width,
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                ),
                child: Image.network(
                  widget.productimage,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: width * 0.1),
            child: Text(
              '\$${widget.price}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: height * 0.03),
            ),
          ),
          Divider(),
          InkWell(
            onTap: (() {
              raitingdialogue();
            }),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: width * 0.1),
                      child: Text(
                        '${widget.productname}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: blackcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.02),
                      )),
                ),
            
                Expanded(
                  flex: 1,
                  child: RatingBarIndicator(
                    direction: Axis.horizontal,
                    itemSize: 20,
                    itemCount: 5,
                    rating: widget.rating,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: width * 0.05),
                  child: Text(
                    '${ double.parse((widget.rating).toStringAsFixed(2))}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.02),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: width * 0.05),
            child: Text(
              ' (rating :${widget.num_rating} times)',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black38, fontSize: height * 0.015),
            ),
          ),
          Divider(),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: width * 0.1),
              child: Text(
                'Description',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: blackcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.02),
              )),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: width * 0.1),
              child: Text(
                '${widget.description}',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.015),
              )),
          SizedBox(
            height: height * 0.01,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: width * 0.06),
            child: ExpansionTile(
              title: Text(
                'Reviews',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: blackcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.02),
              ),
              children: widget.comments
                  .map((comment) => Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: width * 0.1),
                              child: Text(
                                ' ${comment['comments']} .',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.015),
                              )),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Divider(),
                        ],
                      ))
                  .toList(),
            ),
          ),
          Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.06, right: width * 0.1),
                child: TextFormField(
                    cursorColor: buttoncolor,
                    controller: review,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: textColor,
                        ),
                        onPressed: () async {
                          Provider.of<ProductProvider>(context, listen: false)
                              .addreview(review.text, widget.productid);
                          showtoast('you add a review');
                          review.clear();
                        },
                      ),
                      hintText: 'add your review..',
                      filled: true,
                      fillColor: whitecolor,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid name!';
                      }
                      return null;
                    }),
              )),
          SizedBox(
            height: height * 0.03,
          ),
          Defaultbutton(
              functon: () {
                Provider.of<ProductProvider>(context,listen: false).cardlist(product: widget.product);
                showtoast('you add this item to your card');
              },
              text: 'add to cart',
              height: height * 0.08,
              width:width * 0.8,
              color: textColor
              ),
               SizedBox(
            height: height * 0.01,
          ),
        ]),
      ),
    );
  }
}
