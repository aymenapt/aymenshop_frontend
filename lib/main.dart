import 'package:aymen_shop/controller/categorycontroller/categoryprovider.dart';
import 'package:aymen_shop/controller/productcontroller/productprovider.dart';
import 'package:flutter/material.dart';

import 'package:aymen_shop/layout/shop.layout/mainshopscreen.dart';
import 'package:aymen_shop/layout/onboarding.layout/onboardingscreen.dart';
import 'package:aymen_shop/modules/authscreen/authscreen.dart';
import 'controller/authcontroller/authprovider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final obs =   pref.getBool('obs')??false;
  print(obs);
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_)=>AuthProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (_)=>CategoryProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (_)=>ProductProvider()),
      ],
      child: MyApp(
        obs: obs,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  bool obs;
  
  MyApp({
    Key? key,
    required this.obs,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, value, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: obs
                ? (
                  FutureBuilder(
                  future: value.trylogin(),
                    builder: ((context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? MainShopScreen()
                            : AuthScreen())))
                : OnBoardingScreen()));
  }
}
