import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loginpressed;
  var _error;
  var Email;
  var Password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  //Error validation
  bool validator() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 228, 226, 226),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Form(
                        key: formkey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //error display (if any)
                            showAlert(),

                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        _error = null;
                                        Email = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Email',
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 10),

                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      setState(() {
                                        Password = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Password',
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('ForgotPass');
                                  },
                                  child: const Text('Forget your password?')),
                            ),
                            // rgba(250,254,1,255)
                            Center(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 255, 255, 18),
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () async {
                                  var url = Uri.parse(
                                      'https://thenirmanstore.com/v1/account/login');
                                  // print(_googleSignIn.currentUser?.photoUrl.toString());
                                  var responce = await http.post(url, body: {
                                    'type': '2',
                                    // 'email': '$Email',
                                    'email': '$Email',
                                    'password': '$Password'
                                  });
                                  var json = jsonDecode(responce.body);
                                  // print(responce.statusCode);
                                  print(json['message']);
                                  if (json['status'] == 1) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ));
                                  } else {
                                    setState(() {
                                      _error = json['message'];
                                    });
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 2,
                                child: Container(
                                    height: 43,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // rgba(211, 38, 38, 0.25);
                                      color: Colors.blue[800],
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('MobileLogin');
                                        },
                                        child: Text(
                                          'Use Mobile Number',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'SignUp');
                                },
                                child: Text('Create a new account'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 20.0),
                    //   child: Column(
                    //     children: [
                    //       Center(child: Text('Or login with social account')),
                    //       SizedBox(height: 10),
                    //       Center(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             TextButton(
                    //               onPressed: () async {
                    //                 var _user;
                    //                 final googleUser =
                    //                     await GoogleSignIn().signIn();
                    //                 if (googleUser == null) return;
                    //                 _user = googleUser;
                    //                 final googleAuth =
                    //                     await googleUser.authentication;

                    //                 final credential =
                    //                     GoogleAuthProvider.credential(
                    //                         accessToken: googleAuth.accessToken,
                    //                         idToken: googleAuth.idToken);
                    //                 await FirebaseAuth.instance
                    //                     .signInWithCredential(credential);
                    //                 setState(() {});
                    //               },
                    //               child: const Image(
                    //                   height: 27,
                    //                   image: AssetImage(
                    //                       'assets/images/google.png')),
                    //             ),
                    //             TextButton(
                    //               onPressed: () {},
                    //               child: const Image(
                    //                   height: 27,
                    //                   image:
                    //                       AssetImage('assets/images/fb.png')),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ]),
            ),
          )),
    );
  }

  //Error Showing Widget
  Widget showAlert() {
    if (_error != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline_outlined, color: Colors.red),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "$_error",
                  style: TextStyle(color: Colors.red),
                )),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
