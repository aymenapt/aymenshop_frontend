import 'package:flutter/material.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/default_button/defaultbutton.dart';
import '../../shared/styles/styles.dart';
import '../authscreen/authscreen.dart';


class PageView3 extends StatelessWidget {
  PageController controller;
  PageView3({required PageController this.controller});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.09,
        ),
        Expanded(
          flex:9,
          child: Container(
            child: Image.asset(
                "assets/images/Online shopping Customizable Isometric Illustrations _ Amico Style.png"),
          ),
        ),
       
           Expanded(
            flex: 1,
             child: Text(
              "What do we offer you",
              style: TextStyle(
                  color: blackcolor,
                  fontSize: width < 286 ? 18 : 25,
                  fontWeight: FontWeight.bold),
              textAlign: width <= 300 ? TextAlign.right : TextAlign.center,
                     
                   ),
           ),
        Expanded(
          flex: 3,
          child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "We offer for you latest products safety and good proucts quality also ast delevry ",
                style: TextStyle(
                  color: blackcolor,
                  fontSize: width < 286 ? 18 : 20,
                ),
                textAlign: TextAlign.left,
              )),
        ),
        SizedBox(
          height: height * 0.15,
        ),
        
           Expanded(
            flex: 1,
             child: Defaultbutton(
                functon: ()async {
                   final pref = await SharedPreferences.getInstance();
              pref.setBool('obs', true);
               Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => AuthScreen())));
  
                },
                width: width * 0.7,
                height: height * 0.05,
                color: buttoncolor,
                text: 'Shopping Now'),
           ),
        
        const SizedBox(
          height: 16,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          axisDirection: Axis.horizontal,
          effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Color.fromARGB(255, 117, 114, 119),
              activeDotColor: buttoncolor),
        ),
      ],
    );
  }
}
