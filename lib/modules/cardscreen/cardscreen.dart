import 'package:aymen_shop/models/productsmodels/productmodels.dart';
import 'package:aymen_shop/modules/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/productcontroller/productprovider.dart';
import '../../layout/shop.layout/mainshopscreen.dart';
import '../../shared/components/default_button/defaultbutton.dart';
import '../../shared/components/productcard/productcard.dart';
import '../../shared/styles/styles.dart';
import '../productdetail/productdetailscreen.dart';
class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<Product>? cardlist=[] ;
  getcardlist(){
  cardlist= Provider.of<ProductProvider>(context,listen: false).cardproducts;
  print(cardlist);
  }
  @override
  void initState() {
    getcardlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: textColor,
        title: Text('card', style: TextStyle(color: whitecolor)),
      ),
      body: SingleChildScrollView(
        child: cardlist!.isEmpty? Column(
          
          children: [
            
            SizedBox(height: height*0.1,),
            Container(alignment: Alignment.center,
            child: Image.asset('assets/images/Add to cart Customizable Isometric Illustrations _ Amico Style.png'),
            ),
               SizedBox(height: height*0.08,),
              Defaultbutton(
                functon: () {
                     Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => MainShopScreen())));
                },
                text:  'Add products to your card',
                height: height * 0.08,
                width:width * 0.8,
                color: textColor
                ),
            
          ],
        ):Column(
          children: [
             GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cardlist!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ProductDetailScreen(
                                            productid: cardlist![index].id,
                                            productname: cardlist![index].name,
                                            productimage:
                                                cardlist![index].productimage,
                                            description:
                                                cardlist![index].description,
                                            price: cardlist![index].price,
                                            rating: cardlist![index].avgRating,
                                            num_rating:
                                                cardlist![index].numRating,
                                            comments:
                                                cardlist![index].comments,
                                                product:cardlist![index] ,
                                                )));
                              },
                              
                  
                                child:  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ProductCard(
                                        productname: cardlist![index].name,
                                        productimage: cardlist![index].productimage,
                                        price: cardlist![index].price,
                                        rating: cardlist![index].avgRating,
                                        num_rating: cardlist![index].numRating),
                                  ),
                                 
                                  
                             
                            );
                          }),
                        SizedBox(height: height*0.4,),
                      
                           Defaultbutton(
                                         functon: () {
                                         },
                                         text:  'Buy Now',
                                         height: height * 0.08,
                                         width:width * 0.8,
                                         color: textColor
                                         ),
                     
          ],
        ),
      )
    );
  }
}