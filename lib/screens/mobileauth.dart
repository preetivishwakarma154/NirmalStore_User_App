import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:country_picker/country_picker.dart';

import 'mobileloginwidget.dart';


class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  var OTPrequested = false;
  var _error;

  final FirebaseAuth auth = FirebaseAuth.instance;
  var store = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();

  FocusNode otp1FocusNode = FocusNode();
  FocusNode otp2FocusNode = FocusNode();
  FocusNode otp3FocusNode = FocusNode();
  FocusNode otp4FocusNode = FocusNode();
  FocusNode otp5FocusNode = FocusNode();
  FocusNode otp6FocusNode = FocusNode();

  bool otpfieldempty = false;

  String? numbererror;
  var otperror;

  @override
  void initState() {
    super.initState();

    otp1FocusNode = FocusNode();
    otp2FocusNode = FocusNode();
  }

  @override
  void dispose() {
    otp1FocusNode.dispose();
    otp2FocusNode.dispose();
    otp1Controller.dispose();
    otp2Controller.dispose();
    super.dispose();
  }

  String? authStatus;
  //Error validation
  bool validator() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  var phoneNumber;
  var _verId;

  String otp = "";

  //COOLDOWN

  bool cooldown = false;
  var maxseconds = 120;
  bool recaptchaverifying = false;

  bool num_already_stored = false;

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
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

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  //COOLDOWN

  Future<bool> isPhoneNumberStored(String phoneNumber) async {
    bool isStored = false;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Registered User')
        .where('Phone', isEqualTo: phoneNumber)
        .limit(1)
        .get();

    if (querySnapshot.size > 0) {
      isStored = true;
    }
    if (isStored == true) {
      verifyPhoneNumber(context);
    } else {
      setState(() {
        num_already_stored = false;
      });
    }
    print('ISSTORED ERROR : $isStored');
    return isStored;
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    setState(() {
      recaptchaverifying = true;
      OTPrequested = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await _auth.signInWithPhoneNumber(phoneNumber);

        setState(() {
          authStatus = "Your account is successfully verified";
        });
        setState(() {
          recaptchaverifying = false;
        });
        print(authStatus);
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
        print(authStatus);
      },
      codeSent: (verificationId, forceResendingToken) {
        _verId = verificationId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        print(authStatus);
      },
      codeAutoRetrievalTimeout: (String verId) {
        _verId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
        print(authStatus);
      },
    );
  }

  loginMethod() async {
    if (otp1Controller.text.isNotEmpty ||
        otp2Controller.text.isNotEmpty ||
        otp3Controller.text.isNotEmpty ||
        otp4Controller.text.isNotEmpty ||
        otp5Controller.text.isNotEmpty ||
        otp6Controller.text.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verId, smsCode: otp.toString());
        await _auth.signInWithCredential(credential).then((value) {
          {
            print('number verified');
            Navigator.pushNamed(context, 'HomePage');
          }
        });
      } on FirebaseAuthException catch (e) {
        print('error : $e');
        if (e.message ==
            "The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.") {
          setState(() {
            otperror =
                "The OTP you have entered is invalid, please check again or resend the OTP";
          });
        } else {
          setState(() {
            otperror = e.message;
          });
        }
      }
    } else {
      setState(() {
        otpfieldempty = true;
      });
    }

    // if (verifyforsignup == true) {
    //   try {
    //     await auth.currentUser!.delete();
    //     final user = await auth
    //         .createUserWithEmailAndPassword(
    //             email: newuserEmail!, password: newuserPassword)
    //         .then((value) {
    //       store.collection('Registered User').add({
    //         'Name': newusername,
    //         'Email': newuserEmail,
    //         'Phone': phoneNumber
    //       });
    //     }).then((value) {
    //       verifyforsignup = false;
    //       Navigator.pushReplacementNamed(context, "HomePage");
    //     });
    //   } on FirebaseAuthException catch (e) {
    //     if (e.message == 'The email address is badly formatted.') {
    //       {
    //         setState(() {
    //           _error = 'The email address is invalid, please try again.';
    //         });
    //       }
    //     } else {
    //       _error = e.message;
    //     }
    //     print(e);
    //   }
    // }
  }

// 17006
  var countryselected = '91';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 228, 226, 226),
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            await auth.currentUser!.delete();

            _error = null;
            Navigator.pop(context);
          },
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login with Mobile Number',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    MobileLoginWidget(),
                    // Form(
                    //   key: formkey,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       //error display (if any)
                    //       showAlert(),
                    //       showOTPAlert(),
                    //       if (OTPrequested == true)
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             TextButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   OTPrequested = false;
                    //                 });
                    //               },
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.end,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Icon(
                    //                     Icons.edit_square,
                    //                     size: 19,
                    //                   ),
                    //                   SizedBox(width: 5),
                    //                   Text(
                    //                     'Edit number',
                    //                     style: TextStyle(fontSize: 13),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width,
                    //               child: Text(
                    //                   'An OTP is sent to your mobile number ${phoneNumber}'),
                    //             ),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp1Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}';
                    //                                   if (value.length >= 1) {
                    //                                     otp1FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .nextFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp2Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}${otp2Controller.text}';
                    //                                   if (value.length >= 1) {
                    //                                     otp2FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .nextFocus();
                    //                                   }
                    //                                   if (value.length < 1) {
                    //                                     otp2FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .previousFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp3Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}';
                    //                                   if (value.length >= 1) {
                    //                                     otp3FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .nextFocus();
                    //                                   }
                    //                                   if (value.length < 1) {
                    //                                     otp3FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .previousFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp4Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
                    //                                   if (value.length >= 1) {
                    //                                     otp4FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .nextFocus();
                    //                                   }
                    //                                   if (value.length < 1) {
                    //                                     otp4FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .previousFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp5Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}';

                    //                                   if (value.length >= 1) {
                    //                                     otp5FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .nextFocus();
                    //                                   }
                    //                                   if (value.length < 1) {
                    //                                     otp5FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .previousFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width *
                    //                             0.14,
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.fromLTRB(
                    //                           10, 5, 5, 5),
                    //                       child: Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: TextFormField(
                    //                               controller: otp6Controller,
                    //                               textInputAction:
                    //                                   TextInputAction.next,
                    //                               keyboardType:
                    //                                   TextInputType.number,
                    //                               textAlign: TextAlign.center,
                    //                               inputFormatters: [
                    //                                 LengthLimitingTextInputFormatter(
                    //                                     1),
                    //                               ],
                    //                               onChanged: (value) {
                    //                                 print('+$otp+');
                    //                                 setState(() {
                    //                                   otp =
                    //                                       '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}${otp6Controller.text}';
                    //                                   if (value.length >= 1) {
                    //                                     otp4FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .unfocus();
                    //                                   }

                    //                                   if (value.length < 1) {
                    //                                     otp5FocusNode.unfocus();
                    //                                     FocusScope.of(context)
                    //                                         .previousFocus();
                    //                                   }
                    //                                 });
                    //                               },
                    //                               decoration:
                    //                                   const InputDecoration(
                    //                                       labelStyle: TextStyle(
                    //                                           fontSize: 15)),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )),
                    //               ],
                    //             ),
                    //             SizedBox(height: 5),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("Didn't recieved code?",
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.grey)),
                    //                 TextButton(
                    //                   onPressed: () {},
                    //                   child: Text("Send again",
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold)),
                    //                 ),
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       if (OTPrequested == false)
                    //         Container(
                    //             decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(5)),
                    //             child: Padding(
                    //               padding:
                    //                   const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    //               child: Row(
                    //                 children: [
                    //                   InkWell(
                    //                       onTap: () {
                    //                         // showCountryPicker(
                    //                         //   context: context,
                    //                         //   showPhoneCode:
                    //                         //       true, // optional. Shows phone code before the country name.
                    //                         //   onSelect: (Country country) {
                    //                         //     print(
                    //                         //         'Select country: ${country.displayName}');
                    //                         //   },
                    //                         // );
                    //                         return showCountryPicker(
                    //                           context: context,
                    //                           //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                    //                           // exclude: <String>['KN', 'MF'],
                    //                           favorite: <String>['IN'],
                    //                           //Optional. Shows phone code before the country name.

                    //                           // showWorldWide: false,
                    //                           onSelect: (country) {
                    //                             setState(() {
                    //                               countryselected =
                    //                                   country.phoneCode;
                    //                             });
                    //                             print(
                    //                                 'Select country: ${country.displayName}');
                    //                           },
                    //                           // Optional. Sets the theme for the country list picker.
                    //                           countryListTheme:
                    //                               CountryListThemeData(
                    //                             // Optional. Sets the border radius for the bottomsheet.
                    //                             borderRadius: BorderRadius.only(
                    //                               topLeft:
                    //                                   Radius.circular(40.0),
                    //                               topRight:
                    //                                   Radius.circular(40.0),
                    //                             ),
                    //                             // Optional. Styles the search field.
                    //                             inputDecoration:
                    //                                 InputDecoration(
                    //                               labelText: 'Search',
                    //                               hintText:
                    //                                   'Start typing to search',
                    //                               prefixIcon:
                    //                                   const Icon(Icons.search),
                    //                               border: OutlineInputBorder(
                    //                                 borderSide: BorderSide(
                    //                                   color: const Color(
                    //                                           0xFF8C98A8)
                    //                                       .withOpacity(0.2),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         );
                    //                       },
                    //                       child: Row(
                    //                         children: [
                    //                           Row(
                    //                             children: [
                    //                               Text('+${countryselected}'),
                    //                             ],
                    //                           ),
                    //                           Icon(Icons.arrow_drop_down_sharp)
                    //                         ],
                    //                       )),
                    //                   SizedBox(width: 8),
                    //                   Expanded(
                    //                     child: TextFormField(
                    //                       keyboardType: TextInputType.number,
                    //                       inputFormatters: [
                    //                         LengthLimitingTextInputFormatter(
                    //                             10),
                    //                       ],
                    //                       validator: (value) {
                    //                         if (value!.contains(',')) {
                    //                           numbererror =
                    //                               "Invalid input. Please enter numbers only";
                    //                         }
                    //                         if (value.contains('.')) {
                    //                           numbererror =
                    //                               "Invalid input. Please enter numbers only";
                    //                         }
                    //                         if (value.contains('-')) {
                    //                           numbererror =
                    //                               "Invalid input. Please enter numbers only";
                    //                         }
                    //                         if (value.contains(' ')) {
                    //                           numbererror =
                    //                               "Invalid input. Please enter numbers only without any spaces";
                    //                         }
                    //                         if (value.isEmpty) {
                    //                           numbererror =
                    //                               "Field can't be empty";
                    //                         }
                    //                         if (value.length < 10) {
                    //                           numbererror =
                    //                               "Please enter full 10 digit number";
                    //                         }
                    //                       },
                    //                       onChanged: (value) {
                    //                         print('+$otp+');
                    //                         setState(() {
                    //                           numbererror = null;

                    //                           _error = null;
                    //                           phoneNumber =
                    //                               '+$countryselected$value';
                    //                           print(phoneNumber);
                    //                         });
                    //                       },
                    //                       decoration: InputDecoration(
                    //                           border: InputBorder.none,
                    //                           labelText:
                    //                               'Enter your registered mobile number',
                    //                           labelStyle:
                    //                               TextStyle(fontSize: 15)),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             )),
                    //       if (num_already_stored == true)
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.only(top: 3, bottom: 10.0),
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 width: MediaQuery.of(context).size.width,
                    //                 padding: EdgeInsets.all(0),
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width -
                    //                             100,
                    //                         child: Text(
                    //                           "This number is already registered to another account. Please enter a different number.",
                    //                           style: TextStyle(
                    //                               color: Colors.red,
                    //                               fontSize: 13),
                    //                         )),
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       if (numbererrosr != null)
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.only(top: 3, bottom: 10.0),
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 width: MediaQuery.of(context).size.width,
                    //                 padding: EdgeInsets.all(0),
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width -
                    //                             100,
                    //                         child: Text(
                    //                           "$numbererror",
                    //                           style: TextStyle(
                    //                               color: Colors.red,
                    //                               fontSize: 13),
                    //                         )),
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),

                    //       SizedBox(height: 10),
                    //       Center(
                    //           child: Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         decoration: BoxDecoration(
                    //             // color: Color.fromARGB(255, 255, 255, 18),
                    //             color: Colors.yellow,
                    //             borderRadius: BorderRadius.circular(20)),
                    //         child: TextButton(
                    //           onPressed: () async {
                    //             OTPrequested == false
                    //                 ? isPhoneNumberStored(phoneNumber)
                    //                 : loginMethod();
                    //           },
                    //           child: Text(
                    //             OTPrequested == false
                    //                 ? 'Get OTP'
                    //                 : 'Verify OTP',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    //       if (OTPrequested == false)
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 10.0),
                    //           child: Align(
                    //             alignment: Alignment.center,
                    //             child: Material(
                    //               borderRadius: BorderRadius.circular(30),
                    //               elevation: 2,
                    //               child: Container(
                    //                   height: 43,
                    //                   width: MediaQuery.of(context).size.width *
                    //                       0.6,
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     // rgba(211, 38, 38, 0.25);
                    //                     color: Colors.blue[800],
                    //                   ),
                    //                   child: TextButton(
                    //                       onPressed: () {
                    //                         Navigator.of(context)
                    //                             .pushNamed('Login');
                    //                       },
                    //                       child: Text(
                    //                         'Login with Email',
                    //                         style:
                    //                             TextStyle(color: Colors.white),
                    //                       ))),
                    //             ),
                    //           ),
                    //         ),
                    //       SizedBox(height: 20),
                    //       Center(
                    //         child: InkWell(
                    //           onTap: () {
                    //             Navigator.pushNamed(context, 'SignUp');
                    //           },
                    //           child: Text('Create a new account'),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          Center(
                              child:
                                  Text('Or MobileLogin with social account')),
                          SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    var _user;
                                    final googleUser =
                                        await GoogleSignIn().signIn();
                                    if (googleUser == null) return;
                                    _user = googleUser;
                                    final googleAuth =
                                        await googleUser.authentication;

                                    final credential =
                                        GoogleAuthProvider.credential(
                                            accessToken: googleAuth.accessToken,
                                            idToken: googleAuth.idToken);
                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);
                                    setState(() {});
                                  },
                                  child: const Image(
                                      height: 27,
                                      image: AssetImage(
                                          'assets/images/google.png')),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Image(
                                      height: 27,
                                      image:
                                          AssetImage('assets/images/fb.png')),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          )),
    );
  }

  //OTP Error Widget
  Widget showOTPAlert() {
    return otpfieldempty == true
        ? Container(
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
                      "Please enter full OTP",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),
          )
        : SizedBox();
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
