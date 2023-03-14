import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nirman_store/provider/count_provider.dart';
import 'package:nirman_store/screens/AddAddress.dart';
import 'package:nirman_store/screens/All_Address.dart';
import 'package:nirman_store/screens/OrderDetails.dart';
import 'package:nirman_store/screens/Ordered.dart';
import 'package:nirman_store/screens/ReferandEarn.dart';
import 'package:nirman_store/screens/Settings.dart';
import 'package:nirman_store/screens/SplashScreen.dart';
import 'package:nirman_store/screens/checkout.dart';
import 'package:nirman_store/screens/forgotpass.dart';
import 'package:nirman_store/screens/homepage.dart';
import 'package:nirman_store/screens/login.dart';
import 'package:nirman_store/screens/mobileauth.dart';
import 'package:nirman_store/screens/myorders.dart';
import 'package:nirman_store/screens/payment.dart';
import 'package:nirman_store/screens/productdetails.dart';
import 'package:nirman_store/screens/referearnhistory.dart';
import 'package:nirman_store/screens/signup.dart';
import 'package:nirman_store/screens/subscription.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => countprovider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          'SignUp': (context) => SignUp(),
          'Login': (context) => const Login(),
          'MobileLogin': (context) => MobileLogin(),
          'ForgotPass': (context) => const ForgotPass(),
          'HomePage': (context) => const HomePage(),
          'ProductDetails': (context) => ProductDetails(),
         //'CheckOut': (context) => CheckOut(0),
          'AddAddress': (context) => AddAddress(),

          'Payment': (context) => Payment(),
          'Ordered': (context) => Ordered(),
          'MyOrder': (context) => MyOrder(),
          'OrderDetails': (context) => OrderDetails(),
          'RefernEarn': (context) => RefernEarn(),
          'Settings': (context) => Settings(),
          'ReferEarnHistory': (context) => ReferEarnHistory(),
          'Subscription': (context) => Subscription()
        },
      ),
    );
  }
}
