
import 'package:flutter/material.dart';
import 'package:nirman_store/screens/AddAddressP.dart';
import 'package:nirman_store/screens/All_AddressP.dart';
import 'package:nirman_store/screens/SplashScreen.dart';
import '../screens/cart.dart';
import '../screens/homepage.dart';
import '../screens/login.dart';
import '../screens/mobileauth.dart';
import '../screens/myorders.dart';
import '../screens/payment.dart';


import '../screens/signup.dart';


Future<void> main() async {


  runApp(const MyApp());
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

          'All_Address': (context) => All_AddressP(),
          'AddAddress': (context) => AddAddressP(),
          'Payment': (context) => Payment(),

          'MyOrder': (context) => MyOrder(),

          'Cart': (context) => Cart()
        },

    );
  }
}
