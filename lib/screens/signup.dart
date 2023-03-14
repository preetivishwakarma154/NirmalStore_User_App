import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'VerifiyOTP.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

String? newusername;
String newuserPassword = '';
String? newuserEmail;

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var store = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? phoneNumber;
  String? nameerror;
  String? emailerror;
  String? passworderror;
  String? confirmpassworderror;

  bool fielderror = false;

  var onlynumber;

  bool validator() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  var loginpressed;
  var _error;

  String? newuserconfirmPassword;
  var countryselected = '91';

// MOBILE NUMBER VERIFY LOGICS
  Duration? duration;
  String? formattedTime;
  bool numberverified = false;
  bool OTPrequested = false;
  String? numbererror;
  var otp;
  var authStatus;
  var _verId;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  //COOLDOWN
  bool cooldown = false;
  var maxseconds = 120;
  bool num_already_stored = false;
  bool verifyingfailed = false;

  Timer? _timer;
  Map datalist = Map();
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (maxseconds == 0) {
        timer.cancel();
        setState(() {
          cooldown = false;
        });
      } else {
        setState(() {
          maxseconds--;
        });
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      maxseconds = 120;
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> SendOtp({number, email, password, username}) async {
    try {
      var url =
          Uri.parse('https://thenirmanstore.com/v1/account/social_signup');
      // print(_googleSignIn.currentUser?.photoUrl.toString());
      var responce = await http.post(url, body: {
        'device_token': 'TFTFFGHHHHHHHHHHHHHHHHHU',
        'type': '2',
        'phone': number,
        'email': email,
        'password': password,
        'username': username
      });
      var json = jsonDecode(responce.body);
      // print(responce.statusCode);
      print(json['message']);
      if (json['status'] == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOTP(number: number),
            ));
      } else {
        setState(() {
          _error = json['message'];
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

// MOBILE NUMBER VERIFY LOGICS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          elevation: 0,
          leading: SizedBox(),
        ),
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 25,
              ),
              const Text(
                'Sign up',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(height: 85),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        InputFeild("Name", "Name can't be empty", nameerror),
                        SizedBox(height: 10),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      emailerror = "Email can't be empty";
                                    });
                                  }
                                },
                                onChanged: ((value) {
                                  setState(() {
                                    emailerror = null;
                                    newuserEmail = value;
                                  });
                                }),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                ),
                              ),
                            )),
                        SizedBox(height: 10),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      passworderror = "Enter a valid password";
                                    });
                                  }
                                },
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    newuserPassword = value;
                                    passworderror = null;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                ),
                              ),
                            )),
                        if (passworderror != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 3, bottom: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: Text(
                                            "$passworderror",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (newuserPassword.length > 6) InputBox(context),
                        SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: numberController,
                              initialValue: onlynumber,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value!.contains(',')) {
                                  numbererror =
                                      "Invalid input. Please enter numbers only";
                                }
                                if (value.contains('.')) {
                                  numbererror =
                                      "Invalid input. Please enter numbers only";
                                }
                                if (value.contains('-')) {
                                  numbererror =
                                      "Invalid input. Please enter numbers only";
                                }
                                if (value.contains(' ')) {
                                  numbererror =
                                      "Invalid input. Please enter numbers only without any spaces";
                                }
                                if (value.isEmpty) {
                                  numbererror = "Field can't be empty";
                                }
                                if (value.length < 10) {
                                  numbererror =
                                      "Please enter full 10 digit number";
                                }
                              },
                              decoration: InputDecoration(
                                  suffix: numberverified == true
                                      ? Icon(
                                          Icons.verified_rounded,
                                          color: Colors.blue,
                                        )
                                      : SizedBox(),
                                  border: InputBorder.none,
                                  labelText: 'Enter your mobile number',
                                  labelStyle: TextStyle(fontSize: 15)),
                            )),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 255, 255, 18),
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20)),
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade800,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onPressed: () async {
                              await SendOtp(
                                  number: numberController.text.toString(),
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString(),
                                  username: nameController.text.toString());
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('Login');
                                  },
                                  child:
                                      const Text('Already have an account?')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Padding InputBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        confirmpassworderror = "Enter a valid password";
                      });
                    }
                    if (value != newuserPassword) {
                      setState(() {
                        confirmpassworderror = "Password does not match";
                      });
                    }
                  },
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      newuserconfirmPassword = value;
                      confirmpassworderror = null;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Confirm Password',
                  ),
                ),
              )),
          if (confirmpassworderror != null)
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 10.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              "$confirmpassworderror",
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Container InputFeild(String lable, error, varError) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  nameerror = "Name can't be empty";
                });
              }
            },
            onChanged: (value) {
              setState(() {
                nameerror = null;
                newusername = value;
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Name',
            ),
          ),
        ));
  }
}

//Error Showing Widget
//   Widget showAlert() {
//     if (_error != null) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.error_outline_outlined, color: Colors.red),
//             ),
//             Container(
//                 width: MediaQuery.of(context).size.width - 100,
//                 child: Text(
//                   "$_error",
//                   style: TextStyle(color: Colors.red),
//                 )),
//           ],
//         ),
//       );
//     }
//     return SizedBox(
//       height: 0,
//     );
//   }
