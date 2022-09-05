import 'package:flutter/material.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/default_button/defaultbutton.dart';
import '../../shared/styles/styles.dart';


class PageView2 extends StatelessWidget {
  PageController controller;
  PageView2({required PageController this.controller});

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
                "assets/images/Catalogue Customizable Isometric Illustrations _ Amico Style.png"),
          ),
        ),
       
           Expanded(
            flex: 1,
             child: Text(
              "Aymen Shop",
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
                "With us you can shopping comfortably ,safety and choose the best products for you",
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
                functon: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 700), curve: Curves.easeIn);
                },
                width: width * 0.7,
                height: height * 0.05,
                color: buttoncolor,
                text: 'Next'),
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
