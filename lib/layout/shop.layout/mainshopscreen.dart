
import 'package:flutter/material.dart';

import 'package:aymen_shop/shared/styles/styles.dart';
import '../../modules/cardscreen/cardscreen.dart';
import '../../modules/homescreen/homescreen.dart';
import '../../modules/profilescreen/profilescreen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class MainShopScreen extends StatefulWidget {
  const MainShopScreen({Key? key}) : super(key: key);

  @override
  State<MainShopScreen> createState() => _MainShopScreenState();
}

class _MainShopScreenState extends State<MainShopScreen> {
  int index=1 ;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    
    List pages=[
ProfileScreen(),
HomeScreen(),

CardScreen(),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: shopbackgroungColor,
      bottomNavigationBar: CurvedNavigationBar(
        items:const [      
          Icon(Icons.person, size: 30,color: whitecolor,),
      Icon(Icons.home, size: 30,color: whitecolor),
      Icon(Icons.shopping_cart, size: 30,color: whitecolor),],
      backgroundColor: Colors.transparent,
     buttonBackgroundColor: buttomnavigationColor,
      color: buttomnavigationColor,
      index: index,
      height: 60,
      key: _bottomNavigationKey,
      animationCurve: Curves.easeInOut,
      onTap: (index){
        setState(() {
          this.index=index ;
        });
      },

        ),
      body: pages[index]
    );
  }
}
