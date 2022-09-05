import 'package:aymen_shop/modules/categoryproducts/categoryproducts.dart';
import 'package:aymen_shop/modules/productdetail/productdetailscreen.dart';
import 'package:aymen_shop/modules/searchscreen/searchscreen.dart';
import 'package:aymen_shop/shared/components/buildimage/buildimage.dart';
import 'package:aymen_shop/shared/components/productcard/productcard.dart';
import 'package:flutter/material.dart';

import 'package:aymen_shop/shared/styles/styles.dart';
import 'package:aymen_shop/controller/categorycontroller/categoryprovider.dart';
import 'package:aymen_shop/models/categorymodels/categorymodels.dart';
import 'package:aymen_shop/controller/productcontroller/productprovider.dart';
import 'package:aymen_shop/models/productsmodels/productmodels.dart';
import 'package:aymen_shop/models/adsmodels/adsmodels.dart';
import 'package:aymen_shop/shared/components/categorycard/categorycard.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category>? categorylist;
  List<Product>? latestproducts;
  List<Ads>? adslist;
  //fetch category list
  Future getcategorylist() async {
    categorylist = await Provider.of<CategoryProvider>(context, listen: false)
        .getcategories();
  }

//fetch latest products
  Future getlatestproducts() async {
    latestproducts = await Provider.of<ProductProvider>(context, listen: false)
        .getlatestproducts();
  }

  //get ads list
  Future getadslist() async {
    adslist =
        await Provider.of<ProductProvider>(context, listen: false).getAds();
  }

  @override
  void initState() {
    getcategorylist();
    getlatestproducts();
    getadslist();
    super.initState();
  }

  bool isloading = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController searchingvalue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      backgroundColor: shopbackgroungColor,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.04,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: width * 0.06),
            child: Text(
              'Best Products',
              style: TextStyle(
                  color: textColor,
                  fontSize: height * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            margin: EdgeInsets.only(left: width * 0.06),
            alignment: Alignment.centerLeft,
            child: Text(
              'Perfec Choices!',
              style: TextStyle(color: textColor, fontSize: height * 0.02),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.06, right: width * 0.1),
                child: TextFormField(
                    cursorColor: buttoncolor,
                    controller: searchingvalue,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: buttoncolor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SearchScreen(
                                        serchvalue: searchingvalue.text))));
                          },
                        ),
                        labelText: 'Search',
                        filled: true,
                        fillColor: whitecolor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Colors.white))),
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
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.2,
            width: width * 0.8,
            decoration: BoxDecoration(
                color: whitecolor, borderRadius: BorderRadius.circular(18)),
            child: adslist == null
                ? Center(
                    child: CircularProgressIndicator(
                    color: textColor,
                  ))
                : CarouselSlider.builder(
                    itemCount: adslist!.length,
                    itemBuilder: (context, index, realundex) {
                      final imageurl = adslist![index].image;
                      return buildImage(imageurl, index);
                    },
                    options: CarouselOptions(
                        height: height * 0.2,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5)),
                  ),
          ),

          SizedBox(
            height: height * 0.03,
          ),
          Container(
              alignment: Alignment.centerLeft,
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                  color: whitecolor, borderRadius: BorderRadius.circular(10)),
              child: categorylist == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: textColor,
                    ))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorylist!.length,
                      itemBuilder: ((context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProduct(
                                        categoryname:
                                            categorylist![index].name),
                                  ));
                            },
                            child: CategoryCard(
                                name: categorylist![index].name,
                                image: categorylist![index].image),
                          )))),
          SizedBox(
            height: height * 0.02,
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: width * 0.06),
            child: Text(
              'Latest Products',
              style: TextStyle(
                  color: textColor,
                  fontSize: height * 0.03,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          latestproducts == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: textColor,
                ))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ProductDetailScreen(
                                    productid: latestproducts![index].id,
                                    productname: latestproducts![index].name,
                                    productimage:
                                        latestproducts![index].productimage,
                                    description:
                                        latestproducts![index].description,
                                    price: latestproducts![index].price,
                                    rating: latestproducts![index].avgRating,
                                    num_rating:
                                        latestproducts![index].numRating,
                                    comments:
                                        latestproducts![index].comments,
                                        product:latestproducts![index] ,
                                        )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ProductCard(
                            productname: latestproducts![index].name,
                            productimage: latestproducts![index].productimage,
                            price: latestproducts![index].price,
                            rating: latestproducts![index].avgRating,
                            num_rating: latestproducts![index].numRating),
                      ),
                    );
                  })
          //latestproducts==null?CircularProgressIndicator():Center(child: Text(latestproducts![0].name)),
        ]),
      ),
    );
  }
}
