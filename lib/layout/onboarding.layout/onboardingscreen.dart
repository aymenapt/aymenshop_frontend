import 'package:flutter/material.dart';

import '../../modules/pageview1/pageview1.dart';
import '../../modules/pageview2/pageview2.dart';
import '../../modules/pageview3/pageview3.dart';
import '../../shared/styles/styles.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final controller = PageController();
    return Scaffold(
        backgroundColor: whitecolor,
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PageView1(controller: controller),
            PageView2(controller: controller),
            PageView3(controller: controller),
          ],
        ));
  }
}
