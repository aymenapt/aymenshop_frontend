import 'package:aymen_shop/controller/productcontroller/productprovider.dart';
import 'package:aymen_shop/models/productitemmodel/productitemmodels.dart';
import 'package:aymen_shop/shared/components/toast/toast.dart';
import 'package:aymen_shop/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/productsmodels/productmodels.dart';
import '../../shared/components/productcard/productcard.dart';
import '../productdetail/productdetailscreen.dart';

class SearchScreen extends StatefulWidget {
  final String serchvalue ;

  const SearchScreen({Key? key,required this.serchvalue}) : super(key: key);
 

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductItem? searchproducts;
  var error ;
  getsearchproduct()async{
    try{
 searchproducts=await Provider.of<ProductProvider>(context,listen: false).searchproduct(widget.serchvalue);
    }catch(e){
      error=e ;
      showtoast(error);
    }
 print(widget.serchvalue);
  }
  @override
  void initState() {
    getsearchproduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shopbackgroungColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: Text('search product',style:TextStyle(color:whitecolor)),
      ),
      body:   error!=null?Center(child: const Text('No product',style:TextStyle(color:textColor,fontSize: 30))):
                
               Container(
                height: 300,
            child: InkWell(
          onTap: () {
           //show details 
          },
                      
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          child :searchproducts==null?null: ProductCard(
                              productname: searchproducts!.name,
                              productimage: searchproducts!.getImage,
                              price: searchproducts!.price,
                              rating: searchproducts!.avgRating,
                              num_rating: searchproducts!.numRating),
                        ),
              ))      
    );
  }
}