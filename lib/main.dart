import 'package:flutter/material.dart';
import 'package:nirman_store/screens/Address/AddAddress.dart';
import 'package:nirman_store/screens/Address/All_Address.dart';
import 'package:nirman_store/screens/Homepages/cart.dart';
import 'package:nirman_store/screens/Homepages/myorders.dart';
import 'package:nirman_store/screens/Login/login.dart';
import 'package:nirman_store/screens/Login/mobileauth.dart';
import 'package:nirman_store/screens/Signup/signup.dart';

import 'package:nirman_store/screens/SplashScreen.dart';

import '../screens/homepage.dart';


import '../screens/payment.dart';

 import 'dart:io';
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          'SignUp': (context) => SignUp(),
          'Login': (context) => const Login(),
          'MobileLogin': (context) => MobileLogin(),
          'HomePage': (context) => const HomePage(),
          'All_Address': (context) => All_Address(),
          'AddAddress': (context) => AddAddress(),
          'Payment': (context) => Payment(),
          'MyOrder': (context) => MyOrder(),
          'Cart': (context) => Cart()
        },
    );
  }
}
