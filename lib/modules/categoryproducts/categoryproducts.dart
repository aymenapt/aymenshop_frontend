import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/productcontroller/productprovider.dart';
import '../../models/productsmodels/productmodels.dart';
import '../../shared/components/productcard/productcard.dart';
import '../../shared/styles/styles.dart';
import '../productdetail/productdetailscreen.dart';

class CategoryProduct extends StatefulWidget {
  final String categoryname;

  const CategoryProduct({Key? key, required this.categoryname})
      : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  List<Product>? products;
  Future getproducts() async {
    products = await Provider.of<ProductProvider>(context, listen: false)
        .getcategoryproducts();
  }

  @override
  void initState() {
    getproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   /* Iterable<Product> categoryproducts =
        products!.where((element) => element.categoryname == widget.categoryname)??null;*/
    return Scaffold(
      backgroundColor: shopbackgroungColor,
      appBar: AppBar(
        backgroundColor: textColor,
        title: Text(widget.categoryname, style: TextStyle(color: whitecolor)),
      ),
     
      body: products== null?const Center(
                    child: CircularProgressIndicator(
                    color: textColor,
                  )):
                  GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products!.where((element) => element.categoryname==widget.categoryname).length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ProductDetailScreen(
                                    productid: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].id,
                                    productname: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].name,
                                    productimage:
                                        products!.where((element) => element.categoryname==widget.categoryname).toList()[index].productimage,
                                    description:
                                        products!.where((element) => element.categoryname==widget.categoryname).toList()[index].description,
                                    price: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].price,
                                    rating: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].avgRating,
                                    num_rating:
                                        products!.where((element) => element.categoryname==widget.categoryname).toList()[index].numRating,
                                    comments:
                                        products!.where((element) => element.categoryname==widget.categoryname).toList()[index].comments,
                                      product:  products!.where((element) => element.categoryname==widget.categoryname).toList()[index]
                                        )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ProductCard(
                            productname: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].name,
                            productimage: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].productimage,
                            price: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].price,
                            rating: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].avgRating,
                            num_rating: products!.where((element) => element.categoryname==widget.categoryname).toList()[index].numRating),
                      ),
                    );
                  })
    );
  }
}
