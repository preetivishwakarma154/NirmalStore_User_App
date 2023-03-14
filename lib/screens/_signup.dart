// import 'dart:async';

// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:test_projectt/screens/mobilesignup.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// String? newusername;
// String newuserPassword = '';
// String? newuserEmail;

// class _SignUpState extends State<SignUp> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   var store = FirebaseFirestore.instance;
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   String? phoneNumber;
//   String? nameerror;
//   String? emailerror;
//   String? passworderror;
//   String? confirmpassworderror;

//   bool fielderror = false;

//   var onlynumber;

//   bool validator() {
//     if (formkey.currentState!.validate()) {
//       return true;
//     }
//     return false;
//   }

//   var loginpressed;
//   var _error;

//   String? newuserconfirmPassword;
//   var countryselected = '91';

// // MOBILE NUMBER VERIFY LOGICS
//   Duration? duration;
//   String? formattedTime;
//   bool numberverified = false;
//   bool OTPrequested = false;
//   String? numbererror;
//   var otp;
//   var authStatus;
//   var _verId;
//   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   TextEditingController otp1Controller = TextEditingController();
//   TextEditingController otp2Controller = TextEditingController();
//   TextEditingController otp3Controller = TextEditingController();
//   TextEditingController otp4Controller = TextEditingController();
//   TextEditingController otp5Controller = TextEditingController();
//   TextEditingController otp6Controller = TextEditingController();

//   FocusNode otp1FocusNode = FocusNode();
//   FocusNode otp2FocusNode = FocusNode();
//   FocusNode otp3FocusNode = FocusNode();
//   FocusNode otp4FocusNode = FocusNode();
//   FocusNode otp5FocusNode = FocusNode();
//   FocusNode otp6FocusNode = FocusNode();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   var _store = FirebaseFirestore.instance;
//   bool otpfieldempty = false;
//   var otperror;
//   bool recaptchaverifying = false;
//   //COOLDOWN
//   bool cooldown = false;
//   var maxseconds = 120;
//   bool num_already_stored = false;
//   bool verifyingfailed = false;

//   Timer? _timer;
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (maxseconds == 0) {
//         timer.cancel();
//         setState(() {
//           cooldown = false;
//         });
//       } else {
//         setState(() {
//           maxseconds--;
//         });
//       }
//     });
//   }

//   void stopTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//       _timer = null;
//       maxseconds = 120;
//     }
//   }

//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }
//   //COOLDOWN

//   //OTP Error Widget
//   Widget showOTPAlert() {
//     duration = Duration(seconds: maxseconds);
//     formattedTime = formatDuration(duration!);
//     return Column(
//       children: [
//         if (otpfieldempty == true)
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(Icons.error_outline_outlined, color: Colors.red),
//                 ),
//                 Container(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: Text(
//                       "Please enter full OTP",
//                       style: TextStyle(color: Colors.red),
//                     )),
//               ],
//             ),
//           ),
//         if (otpfieldempty == false && otperror != null)
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(Icons.error_outline_outlined, color: Colors.red),
//                 ),
//                 Container(
//                     width: MediaQuery.of(context).size.width - 100,
//                     child: Text(
//                       "$otperror",
//                       style: TextStyle(color: Colors.red),
//                     )),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Future<bool> isPhoneNumberStored(String phoneNumber) async {
//     bool isStored = false;
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
//         .instance
//         .collection('Registered User')
//         .where('Phone', isEqualTo: phoneNumber)
//         .limit(1)
//         .get();

//     if (querySnapshot.size > 0) {
//       isStored = true;
//     }
//     if (isStored == false) {
//       verifyPhoneNumber(context);
//     } else {
//       setState(() {
//         num_already_stored = true;
//       });
//     }
//     print('ISSTORED ERROR : $isStored');
//     return isStored;
//   }

//   Future<void> verifyPhoneNumber(BuildContext context) async {
//     setState(() {
//       recaptchaverifying = true;
//       OTPrequested = true;
//     });
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       timeout: const Duration(
//         seconds: 120,
//       ),
//       verificationCompleted: (PhoneAuthCredential authCredential) async {
//         // await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);

//         setState(() {
//           authStatus = "Your account is successfully verified";
//           setState(() {
//             recaptchaverifying = false;
//           });
//         });
//         print(authStatus);
//       },
//       verificationFailed: (FirebaseAuthException authException) {
//         setState(() {
//           authStatus = "Authentication failed";
//           verifyingfailed = true;
//           OTPrequested = false;
//           recaptchaverifying = false;
//         });
//         print(authStatus);
//       },
//       codeSent: (verificationId, forceResendingToken) {
//         _verId = verificationId;
//         setState(() {
//           authStatus = "OTP has been successfully send";
//           recaptchaverifying = false;
//           cooldown = true;

//           startTimer();
//         });

//         print(authStatus);
//       },
//       codeAutoRetrievalTimeout: (String verId) {
//         _verId = verId;
//         setState(() {
//           authStatus = "TIMEOUT";
//         });
//         print(authStatus);
//       },
//     );
//   }

//   verifyotp() async {
//     if (otp1Controller.text.isNotEmpty ||
//         otp2Controller.text.isNotEmpty ||
//         otp3Controller.text.isNotEmpty ||
//         otp4Controller.text.isNotEmpty ||
//         otp5Controller.text.isNotEmpty ||
//         otp6Controller.text.isNotEmpty) {
//       try {
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//             verificationId: _verId, smsCode: otp.toString());
//         await auth.signInWithCredential(credential).then((value) {
//           {
//             setState(() {
//               numberverified = true;
//               stopTimer();
//             });

//             print('number verified');
//           }
//         });
//       } on FirebaseAuthException catch (e) {
//         print('error : ${e.message}');
//         if (e.message ==
//             "The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.") {
//           setState(() {
//             otperror =
//                 "The OTP you have entered is invalid, please check again or resend the OTP";
//           });
//         } else {
//           setState(() {
//             otperror = e.message;
//           });
//         }
//       }
//     } else {
//       setState(() {
//         otpfieldempty = true;
//       });
//     }
//   }

// // MOBILE NUMBER VERIFY LOGICS

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 246, 246, 246),
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(0, 226, 226, 226),
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.arrow_back_ios_rounded,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               const Text(
//                 'Sign up',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25),
//               ),
//               SizedBox(height: 85),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Form(
//                     key: formkey,
//                     child: Column(
//                       children: [
//                         showAlert(),
//                         Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 30.0),
//                               child: TextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     setState(() {
//                                       nameerror = "Name can't be empty";
//                                     });
//                                   }
//                                 },
//                                 onChanged: (value) {
//                                   setState(() {
//                                     nameerror = null;
//                                     newusername = value;
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   labelText: 'Name',
//                                 ),
//                               ),
//                             )),
//                         if (nameerror != null)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 3, bottom: 10.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: EdgeInsets.all(0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width -
//                                               100,
//                                           child: Text(
//                                             "$nameerror",
//                                             style: TextStyle(
//                                                 color: Colors.red,
//                                                 fontSize: 13),
//                                           )),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         SizedBox(height: 10),
//                         Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 30.0),
//                               child: TextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     setState(() {
//                                       emailerror = "Email can't be empty";
//                                     });
//                                   }
//                                 },
//                                 onChanged: ((value) {
//                                   setState(() {
//                                     emailerror = null;
//                                     newuserEmail = value;
//                                   });
//                                 }),
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   labelText: 'Email',
//                                 ),
//                               ),
//                             )),
//                         if (emailerror != null)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 3, bottom: 10.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: EdgeInsets.all(0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width -
//                                               100,
//                                           child: Text(
//                                             "$emailerror",
//                                             style: TextStyle(
//                                                 color: Colors.red,
//                                                 fontSize: 13),
//                                           )),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         SizedBox(height: 10),
//                         Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 30.0),
//                               child: TextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     setState(() {
//                                       passworderror = "Enter a valid password";
//                                     });
//                                   }
//                                 },
//                                 obscureText: true,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     newuserPassword = value;
//                                     passworderror = null;
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   labelText: 'Password',
//                                 ),
//                               ),
//                             )),
//                         if (passworderror != null)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 3, bottom: 10.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: EdgeInsets.all(0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width -
//                                               100,
//                                           child: Text(
//                                             "$passworderror",
//                                             style: TextStyle(
//                                                 color: Colors.red,
//                                                 fontSize: 13),
//                                           )),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         if (newuserPassword.length > 6)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(5)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 30.0),
//                                       child: TextFormField(
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             setState(() {
//                                               confirmpassworderror =
//                                                   "Enter a valid password";
//                                             });
//                                           }
//                                           if (value != newuserPassword) {
//                                             setState(() {
//                                               confirmpassworderror =
//                                                   "Password does not match";
//                                             });
//                                           }
//                                         },
//                                         obscureText: true,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             newuserconfirmPassword = value;
//                                             confirmpassworderror = null;
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                           labelText: 'Confirm Password',
//                                         ),
//                                       ),
//                                     )),
//                                 if (confirmpassworderror != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 3, bottom: 10.0),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           padding: EdgeInsets.all(0),
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width -
//                                                       100,
//                                                   child: Text(
//                                                     "$confirmpassworderror",
//                                                     style: TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 13),
//                                                   )),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         SizedBox(height: 10),
//                         // recaptchaverifying == false && verifyingfailed == false
//                         //     ? Form(
//                         //         key: _formkey,
//                         //         child: Column(
//                         //           children: [
//                         //             if (verifyingfailed == true)
//                         //               Padding(
//                         //                 padding: const EdgeInsets.symmetric(
//                         //                     vertical: 10.0),
//                         //                 child: Row(
//                         //                   mainAxisAlignment:
//                         //                       MainAxisAlignment.center,
//                         //                   children: [
//                         //                     Text(
//                         //                         "Verification Failed, please try again later",
//                         //                         style: TextStyle(
//                         //                             color: Color.fromARGB(
//                         //                                 255, 7, 15, 22),
//                         //                             fontWeight:
//                         //                                 FontWeight.bold)),
//                         //                     SizedBox(width: 20),
//                         //                     Icon(
//                         //                       Icons.cancel,
//                         //                       color: Colors.red,
//                         //                     )
//                         //                   ],
//                         //                 ),
//                         //               ),
//                         //             if (OTPrequested == true &&
//                         //                 numberverified == false &&
//                         //                 verifyingfailed == false)
//                         //               Column(
//                         //                 mainAxisAlignment:
//                         //                     MainAxisAlignment.start,
//                         //                 crossAxisAlignment:
//                         //                     CrossAxisAlignment.start,
//                         //                 children: [
//                         //                   TextButton(
//                         //                     onPressed: () {
//                         //                       setState(() {
//                         //                         OTPrequested = false;
//                         //                       });
//                         //                     },
//                         //                     child: Row(
//                         //                       mainAxisAlignment:
//                         //                           MainAxisAlignment.end,
//                         //                       crossAxisAlignment:
//                         //                           CrossAxisAlignment.center,
//                         //                       children: [
//                         //                         Icon(
//                         //                           Icons.edit_square,
//                         //                           size: 19,
//                         //                         ),
//                         //                         SizedBox(width: 5),
//                         //                         Text(
//                         //                           'Edit number',
//                         //                           style:
//                         //                               TextStyle(fontSize: 13),
//                         //                         )
//                         //                       ],
//                         //                     ),
//                         //                   ),
//                         //                   SizedBox(
//                         //                     width: MediaQuery.of(context)
//                         //                         .size
//                         //                         .width,
//                         //                     child: Text(
//                         //                         'An OTP is sent to your mobile number ${phoneNumber}'),
//                         //                   ),
//                         //                   Row(
//                         //                     mainAxisAlignment:
//                         //                         MainAxisAlignment.center,
//                         //                     children: [
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp1Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otpfieldempty =
//                         //                                             false;
//                         //                                         otperror = null;
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}';
//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp1FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .nextFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp2Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otpfieldempty =
//                         //                                             false;
//                         //                                         otperror = null;
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}${otp2Controller.text}';
//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp2FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .nextFocus();
//                         //                                         }
//                         //                                         if (value
//                         //                                                 .length <
//                         //                                             1) {
//                         //                                           otp2FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .previousFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp3Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       otpfieldempty =
//                         //                                           false;
//                         //                                       otperror = null;
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}';
//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp3FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .nextFocus();
//                         //                                         }
//                         //                                         if (value
//                         //                                                 .length <
//                         //                                             1) {
//                         //                                           otp3FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .previousFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp4Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       otpfieldempty =
//                         //                                           false;
//                         //                                       otperror = null;
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp4FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .nextFocus();
//                         //                                         }
//                         //                                         if (value
//                         //                                                 .length <
//                         //                                             1) {
//                         //                                           otp4FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .previousFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp5Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       otpfieldempty =
//                         //                                           false;
//                         //                                       otperror = null;
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}';

//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp5FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .nextFocus();
//                         //                                         }
//                         //                                         if (value
//                         //                                                 .length <
//                         //                                             1) {
//                         //                                           otp5FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .previousFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                       Container(
//                         //                           width: MediaQuery.of(context)
//                         //                                   .size
//                         //                                   .width *
//                         //                               0.14,
//                         //                           child: Padding(
//                         //                             padding: const EdgeInsets
//                         //                                 .fromLTRB(10, 5, 5, 5),
//                         //                             child: Row(
//                         //                               children: [
//                         //                                 Expanded(
//                         //                                   child: TextFormField(
//                         //                                     controller:
//                         //                                         otp6Controller,
//                         //                                     textInputAction:
//                         //                                         TextInputAction
//                         //                                             .next,
//                         //                                     keyboardType:
//                         //                                         TextInputType
//                         //                                             .number,
//                         //                                     textAlign: TextAlign
//                         //                                         .center,
//                         //                                     inputFormatters: [
//                         //                                       LengthLimitingTextInputFormatter(
//                         //                                           1),
//                         //                                     ],
//                         //                                     onChanged: (value) {
//                         //                                       otpfieldempty =
//                         //                                           false;
//                         //                                       otperror = null;
//                         //                                       print('+$otp+');
//                         //                                       setState(() {
//                         //                                         otp =
//                         //                                             '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}${otp6Controller.text}';
//                         //                                         if (value
//                         //                                                 .length >=
//                         //                                             1) {
//                         //                                           otp4FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .unfocus();
//                         //                                         }

//                         //                                         if (value
//                         //                                                 .length <
//                         //                                             1) {
//                         //                                           otp5FocusNode
//                         //                                               .unfocus();
//                         //                                           FocusScope.of(
//                         //                                                   context)
//                         //                                               .previousFocus();
//                         //                                         }
//                         //                                       });
//                         //                                     },
//                         //                                     decoration: const InputDecoration(
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                                   ),
//                         //                                 ),
//                         //                               ],
//                         //                             ),
//                         //                           )),
//                         //                     ],
//                         //                   ),
//                         //                   showOTPAlert(),
//                         //                   SizedBox(height: 5),
//                         //                   Row(
//                         //                     mainAxisAlignment:
//                         //                         MainAxisAlignment.center,
//                         //                     children: [
//                         //                       if (cooldown == true)
//                         //                         Text(formattedTime!),
//                         //                       SizedBox(width: 8),
//                         //                       Row(
//                         //                         mainAxisAlignment:
//                         //                             MainAxisAlignment.center,
//                         //                         children: [
//                         //                           Text("Didn't recieved code?",
//                         //                               style: TextStyle(
//                         //                                   color: cooldown
//                         //                                       ? Color.fromARGB(
//                         //                                           160,
//                         //                                           158,
//                         //                                           158,
//                         //                                           158)
//                         //                                       : Colors.black)),
//                         //                           TextButton(
//                         //                             onPressed: () {
//                         //                               if (cooldown == false) {
//                         //                                 verifyPhoneNumber(
//                         //                                     context);
//                         //                               }
//                         //                             },
//                         //                             child: Text("Send again",
//                         //                                 style: TextStyle(
//                         //                                     fontWeight:
//                         //                                         FontWeight.bold,
//                         //                                     color: cooldown
//                         //                                         ? Color
//                         //                                             .fromARGB(
//                         //                                                 134,
//                         //                                                 33,
//                         //                                                 149,
//                         //                                                 243)
//                         //                                         : Colors.blue)),
//                         //                           ),
//                         //                         ],
//                         //                       ),
//                         //                     ],
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             if (OTPrequested == false &&
//                         //                     verifyingfailed == false ||
//                         //                 numberverified == true &&
//                         //                     verifyingfailed == false)
//                         //               Container(
//                         //                   decoration: BoxDecoration(
//                         //                       color: Colors.white,
//                         //                       borderRadius:
//                         //                           BorderRadius.circular(5)),
//                         //                   child: Padding(
//                         //                     padding: const EdgeInsets.fromLTRB(
//                         //                         10, 5, 5, 5),
//                         //                     child: Column(
//                         //                       children: [
//                         //                         Row(
//                         //                           children: [
//                         //                             InkWell(
//                         //                                 onTap: () {
//                         //                                   // showCountryPicker(
//                         //                                   //   context: context,
//                         //                                   //   showPhoneCode:
//                         //                                   //       true, // optional. Shows phone code before the country name.
//                         //                                   //   onSelect: (Country country) {
//                         //                                   //     print(
//                         //                                   //         'Select country: ${country.displayName}');
//                         //                                   //   },
//                         //                                   // );
//                         //                                   return showCountryPicker(
//                         //                                     context: context,
//                         //                                     //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
//                         //                                     // exclude: <String>['KN', 'MF'],
//                         //                                     favorite: <String>[
//                         //                                       'IN'
//                         //                                     ],
//                         //                                     //Optional. Shows phone code before the country name.

//                         //                                     // showWorldWide: false,
//                         //                                     onSelect:
//                         //                                         (country) {
//                         //                                       setState(() {
//                         //                                         countryselected =
//                         //                                             country
//                         //                                                 .phoneCode;
//                         //                                       });
//                         //                                       print(
//                         //                                           'Select country: ${country.displayName}');
//                         //                                     },
//                         //                                     // Optional. Sets the theme for the country list picker.
//                         //                                     countryListTheme:
//                         //                                         CountryListThemeData(
//                         //                                       // Optional. Sets the border radius for the bottomsheet.
//                         //                                       borderRadius:
//                         //                                           BorderRadius
//                         //                                               .only(
//                         //                                         topLeft: Radius
//                         //                                             .circular(
//                         //                                                 40.0),
//                         //                                         topRight: Radius
//                         //                                             .circular(
//                         //                                                 40.0),
//                         //                                       ),
//                         //                                       // Optional. Styles the search field.
//                         //                                       inputDecoration:
//                         //                                           InputDecoration(
//                         //                                         labelText:
//                         //                                             'Search',
//                         //                                         hintText:
//                         //                                             'Start typing to search',
//                         //                                         prefixIcon:
//                         //                                             const Icon(Icons
//                         //                                                 .search),
//                         //                                         border:
//                         //                                             OutlineInputBorder(
//                         //                                           borderSide:
//                         //                                               BorderSide(
//                         //                                             color: const Color(
//                         //                                                     0xFF8C98A8)
//                         //                                                 .withOpacity(
//                         //                                                     0.2),
//                         //                                           ),
//                         //                                         ),
//                         //                                       ),
//                         //                                     ),
//                         //                                   );
//                         //                                 },
//                         //                                 child: Row(
//                         //                                   children: [
//                         //                                     Row(
//                         //                                       children: [
//                         //                                         Text(
//                         //                                             '+${countryselected}'),
//                         //                                       ],
//                         //                                     ),
//                         //                                     Icon(Icons
//                         //                                         .arrow_drop_down_sharp)
//                         //                                   ],
//                         //                                 )),
//                         //                             SizedBox(width: 8),
//                         //                             Expanded(
//                         //                               child: TextFormField(
//                         //                                 initialValue:
//                         //                                     onlynumber,
//                         //                                 keyboardType:
//                         //                                     TextInputType
//                         //                                         .number,
//                         //                                 inputFormatters: [
//                         //                                   LengthLimitingTextInputFormatter(
//                         //                                       10),
//                         //                                 ],
//                         //                                 validator: (value) {
//                         //                                   if (value!
//                         //                                       .contains(',')) {
//                         //                                     numbererror =
//                         //                                         "Invalid input. Please enter numbers only";
//                         //                                   }
//                         //                                   if (value
//                         //                                       .contains('.')) {
//                         //                                     numbererror =
//                         //                                         "Invalid input. Please enter numbers only";
//                         //                                   }
//                         //                                   if (value
//                         //                                       .contains('-')) {
//                         //                                     numbererror =
//                         //                                         "Invalid input. Please enter numbers only";
//                         //                                   }
//                         //                                   if (value
//                         //                                       .contains(' ')) {
//                         //                                     numbererror =
//                         //                                         "Invalid input. Please enter numbers only without any spaces";
//                         //                                   }
//                         //                                   if (value.isEmpty) {
//                         //                                     numbererror =
//                         //                                         "Field can't be empty";
//                         //                                   }
//                         //                                   if (value.length <
//                         //                                       10) {
//                         //                                     numbererror =
//                         //                                         "Please enter full 10 digit number";
//                         //                                   }
//                         //                                 },
//                         //                                 onChanged: (value) {
//                         //                                   print('+$otp+');
//                         //                                   setState(() {
//                         //                                     numbererror = null;
//                         //                                     num_already_stored =
//                         //                                         false;
//                         //                                     numberverified =
//                         //                                         false;
//                         //                                     OTPrequested =
//                         //                                         false;
//                         //                                     stopTimer();

//                         //                                     otp1Controller =
//                         //                                         TextEditingController();
//                         //                                     otp2Controller =
//                         //                                         TextEditingController();
//                         //                                     otp3Controller =
//                         //                                         TextEditingController();
//                         //                                     otp4Controller =
//                         //                                         TextEditingController();
//                         //                                     otp5Controller =
//                         //                                         TextEditingController();
//                         //                                     otp6Controller =
//                         //                                         TextEditingController();
//                         //                                     // _error = null;
//                         //                                     onlynumber = value;
//                         //                                     phoneNumber =
//                         //                                         '+$countryselected$value';
//                         //                                     print(phoneNumber);
//                         //                                   });
//                         //                                 },
//                         //                                 decoration:
//                         //                                     InputDecoration(
//                         //                                         suffix:
//                         //                                             numberverified ==
//                         //                                                     true
//                         //                                                 ? Icon(
//                         //                                                     Icons.verified_rounded,
//                         //                                                     color:
//                         //                                                         Colors.blue,
//                         //                                                   )
//                         //                                                 : SizedBox(),
//                         //                                         border:
//                         //                                             InputBorder
//                         //                                                 .none,
//                         //                                         labelText:
//                         //                                             'Enter your mobile number',
//                         //                                         labelStyle:
//                         //                                             TextStyle(
//                         //                                                 fontSize:
//                         //                                                     15)),
//                         //                               ),
//                         //                             ),
//                         //                           ],
//                         //                         ),
//                         //                         if (otperror == true)
//                         //                           Row(
//                         //                             children: [],
//                         //                           )
//                         //                       ],
//                         //                     ),
//                         //                   )),
//                         //             if (num_already_stored == true)
//                         //               Padding(
//                         //                 padding: const EdgeInsets.only(
//                         //                     top: 3, bottom: 10.0),
//                         //                 child: Column(
//                         //                   children: [
//                         //                     Container(
//                         //                       width: MediaQuery.of(context)
//                         //                           .size
//                         //                           .width,
//                         //                       padding: EdgeInsets.all(0),
//                         //                       child: Row(
//                         //                         children: [
//                         //                           Container(
//                         //                               width:
//                         //                                   MediaQuery.of(context)
//                         //                                           .size
//                         //                                           .width -
//                         //                                       100,
//                         //                               child: Text(
//                         //                                 "This number is already registered to another account. Please enter a different number.",
//                         //                                 style: TextStyle(
//                         //                                     color: Colors.red,
//                         //                                     fontSize: 13),
//                         //                               )),
//                         //                         ],
//                         //                       ),
//                         //                     )
//                         //                   ],
//                         //                 ),
//                         //               ),
//                         //             if (numbererror != null)
//                         //               Padding(
//                         //                 padding: const EdgeInsets.only(
//                         //                     top: 3, bottom: 10.0),
//                         //                 child: Column(
//                         //                   children: [
//                         //                     Container(
//                         //                       width: MediaQuery.of(context)
//                         //                           .size
//                         //                           .width,
//                         //                       padding: EdgeInsets.all(0),
//                         //                       child: Row(
//                         //                         children: [
//                         //                           Container(
//                         //                               width:
//                         //                                   MediaQuery.of(context)
//                         //                                           .size
//                         //                                           .width -
//                         //                                       100,
//                         //                               child: Text(
//                         //                                 "$numbererror",
//                         //                                 style: TextStyle(
//                         //                                     color: Colors.red,
//                         //                                     fontSize: 13),
//                         //                               )),
//                         //                         ],
//                         //                       ),
//                         //                     )
//                         //                   ],
//                         //                 ),
//                         //               ),
//                         //             // SizedBox(height: 20),
//                         //             if (numberverified == false)
//                         //               Padding(
//                         //                 padding: const EdgeInsets.only(top: 20),
//                         //                 child: Center(
//                         //                     child: Container(
//                         //                   width: 190,
//                         //                   decoration: BoxDecoration(
//                         //                       // color: Color.fromARGB(255, 255, 255, 18),
//                         //                       color: Color.fromARGB(
//                         //                           255, 0, 105, 192),
//                         //                       borderRadius:
//                         //                           BorderRadius.circular(10)),
//                         //                   child: TextButton(
//                         //                     onPressed: () async {
//                         //                       if (validator()) {
//                         //                         if (numbererror == null) {
//                         //                           OTPrequested == false
//                         //                               // ? verifyPhoneNumber(context)
//                         //                               ? isPhoneNumberStored(
//                         //                                   phoneNumber!)
//                         //                               : verifyotp();
//                         //                         }
//                         //                       }
//                         //                       setState(() {});
//                         //                     },
//                         //                     child: Text(
//                         //                       OTPrequested == false
//                         //                           ? 'Get OTP'
//                         //                           : 'Verify OTP',
//                         //                       style: TextStyle(
//                         //                         color: Colors.white,
//                         //                       ),
//                         //                     ),
//                         //                   ),
//                         //                 )),
//                         //               ),
//                         //             SizedBox(height: 15),
//                         //           ],
//                         //         ),
//                         //       )
//                         //     : Padding(
//                         //         padding:
//                         //             const EdgeInsets.symmetric(vertical: 10.0),
//                         //         child: Row(
//                         //           mainAxisAlignment: MainAxisAlignment.center,
//                         //           children: [
//                         //             Text(
//                         //                 "Verifying you're not a robot,\nhold tight!",
//                         //                 style: TextStyle(
//                         //                     color:
//                         //                         Color.fromARGB(255, 7, 15, 22),
//                         //                     fontWeight: FontWeight.bold)),
//                         //             SizedBox(width: 25),
//                         //             CircularProgressIndicator.adaptive()
//                         //           ],
//                         //         ),
//                         //       ),

//                         Form(
//                           key: _formkey,
//                           child: Column(
//                             children: [
//                               if (verifyingfailed == true)
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                           "Verification Failed, please try again later",
//                                           style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 15, 22),
//                                               fontWeight: FontWeight.bold)),
//                                       SizedBox(width: 20),
//                                       Icon(
//                                         Icons.cancel,
//                                         color: Colors.red,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               if (OTPrequested == true &&
//                                   numberverified == false &&
//                                   verifyingfailed == false)
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           OTPrequested = false;
//                                         });
//                                       },
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Icon(
//                                             Icons.edit_square,
//                                             size: 19,
//                                           ),
//                                           SizedBox(width: 5),
//                                           Text(
//                                             'Edit number',
//                                             style: TextStyle(fontSize: 13),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Text(
//                                           'An OTP is sent to your mobile number ${phoneNumber}'),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp1Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otpfieldempty = false;
//                                                           otperror = null;
//                                                           otp =
//                                                               '${otp1Controller.text}';
//                                                           if (value.length >=
//                                                               1) {
//                                                             otp1FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .nextFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp2Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otpfieldempty = false;
//                                                           otperror = null;
//                                                           otp =
//                                                               '${otp1Controller.text}${otp2Controller.text}';
//                                                           if (value.length >=
//                                                               1) {
//                                                             otp2FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .nextFocus();
//                                                           }
//                                                           if (value.length <
//                                                               1) {
//                                                             otp2FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .previousFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp3Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         otpfieldempty = false;
//                                                         otperror = null;
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otp =
//                                                               '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}';
//                                                           if (value.length >=
//                                                               1) {
//                                                             otp3FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .nextFocus();
//                                                           }
//                                                           if (value.length <
//                                                               1) {
//                                                             otp3FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .previousFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp4Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         otpfieldempty = false;
//                                                         otperror = null;
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otp =
//                                                               '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
//                                                           if (value.length >=
//                                                               1) {
//                                                             otp4FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .nextFocus();
//                                                           }
//                                                           if (value.length <
//                                                               1) {
//                                                             otp4FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .previousFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp5Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         otpfieldempty = false;
//                                                         otperror = null;
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otp =
//                                                               '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}';

//                                                           if (value.length >=
//                                                               1) {
//                                                             otp5FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .nextFocus();
//                                                           }
//                                                           if (value.length <
//                                                               1) {
//                                                             otp5FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .previousFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.14,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 5, 5),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           otp6Controller,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             1),
//                                                       ],
//                                                       onChanged: (value) {
//                                                         otpfieldempty = false;
//                                                         otperror = null;
//                                                         print('+$otp+');
//                                                         setState(() {
//                                                           otp =
//                                                               '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}${otp6Controller.text}';
//                                                           if (value.length >=
//                                                               1) {
//                                                             otp4FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .unfocus();
//                                                           }

//                                                           if (value.length <
//                                                               1) {
//                                                             otp5FocusNode
//                                                                 .unfocus();
//                                                             FocusScope.of(
//                                                                     context)
//                                                                 .previousFocus();
//                                                           }
//                                                         });
//                                                       },
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               labelStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                           15)),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                       ],
//                                     ),
//                                     showOTPAlert(),
//                                     SizedBox(height: 5),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         if (cooldown == true)
//                                           Text(formattedTime!),
//                                         SizedBox(width: 8),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text("Didn't recieved code?",
//                                                 style: TextStyle(
//                                                     color: cooldown
//                                                         ? Color.fromARGB(
//                                                             160, 158, 158, 158)
//                                                         : Colors.black)),
//                                             TextButton(
//                                               onPressed: () {
//                                                 if (cooldown == false) {
//                                                   verifyPhoneNumber(context);
//                                                 }
//                                               },
//                                               child: Text("Send again",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: cooldown
//                                                           ? Color.fromARGB(
//                                                               134, 33, 149, 243)
//                                                           : Colors.blue)),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               if (OTPrequested == false ||
//                                   numberverified == true)
//                                 Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(5)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           10, 5, 5, 5),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                   onTap: () {
//                                                     // showCountryPicker(
//                                                     //   context: context,
//                                                     //   showPhoneCode:
//                                                     //       true, // optional. Shows phone code before the country name.
//                                                     //   onSelect: (Country country) {
//                                                     //     print(
//                                                     //         'Select country: ${country.displayName}');
//                                                     //   },
//                                                     // );
//                                                     return showCountryPicker(
//                                                       context: context,
//                                                       //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
//                                                       // exclude: <String>['KN', 'MF'],
//                                                       favorite: <String>['IN'],
//                                                       //Optional. Shows phone code before the country name.

//                                                       // showWorldWide: false,
//                                                       onSelect: (country) {
//                                                         setState(() {
//                                                           countryselected =
//                                                               country.phoneCode;
//                                                         });
//                                                         print(
//                                                             'Select country: ${country.displayName}');
//                                                       },
//                                                       // Optional. Sets the theme for the country list picker.
//                                                       countryListTheme:
//                                                           CountryListThemeData(
//                                                         // Optional. Sets the border radius for the bottomsheet.
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   40.0),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   40.0),
//                                                         ),
//                                                         // Optional. Styles the search field.
//                                                         inputDecoration:
//                                                             InputDecoration(
//                                                           labelText: 'Search',
//                                                           hintText:
//                                                               'Start typing to search',
//                                                           prefixIcon:
//                                                               const Icon(
//                                                                   Icons.search),
//                                                           border:
//                                                               OutlineInputBorder(
//                                                             borderSide:
//                                                                 BorderSide(
//                                                               color: const Color(
//                                                                       0xFF8C98A8)
//                                                                   .withOpacity(
//                                                                       0.2),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                   child: Row(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                               '+${countryselected}'),
//                                                         ],
//                                                       ),
//                                                       Icon(Icons
//                                                           .arrow_drop_down_sharp)
//                                                     ],
//                                                   )),
//                                               SizedBox(width: 8),
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   initialValue: onlynumber,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   inputFormatters: [
//                                                     LengthLimitingTextInputFormatter(
//                                                         10),
//                                                   ],
//                                                   validator: (value) {
//                                                     if (value!.contains(',')) {
//                                                       numbererror =
//                                                           "Invalid input. Please enter numbers only";
//                                                     }
//                                                     if (value.contains('.')) {
//                                                       numbererror =
//                                                           "Invalid input. Please enter numbers only";
//                                                     }
//                                                     if (value.contains('-')) {
//                                                       numbererror =
//                                                           "Invalid input. Please enter numbers only";
//                                                     }
//                                                     if (value.contains(' ')) {
//                                                       numbererror =
//                                                           "Invalid input. Please enter numbers only without any spaces";
//                                                     }
//                                                     if (value.isEmpty) {
//                                                       numbererror =
//                                                           "Field can't be empty";
//                                                     }
//                                                     if (value.length < 10) {
//                                                       numbererror =
//                                                           "Please enter full 10 digit number";
//                                                     }
//                                                   },
//                                                   onChanged: (value) {
//                                                     print('+$otp+');
//                                                     setState(() {
//                                                       numbererror = null;
//                                                       num_already_stored =
//                                                           false;
//                                                       // _error = null;
//                                                       phoneNumber =
//                                                           '+$countryselected$value';
//                                                       onlynumber = value;
//                                                       print(phoneNumber);
//                                                     });
//                                                   },
//                                                   decoration: InputDecoration(
//                                                       suffix: numberverified ==
//                                                               true
//                                                           ? Icon(
//                                                               Icons
//                                                                   .verified_rounded,
//                                                               color:
//                                                                   Colors.blue,
//                                                             )
//                                                           : SizedBox(),
//                                                       border: InputBorder.none,
//                                                       labelText:
//                                                           'Enter your mobile number',
//                                                       labelStyle: TextStyle(
//                                                           fontSize: 15)),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           if (otperror == true)
//                                             Row(
//                                               children: [],
//                                             )
//                                         ],
//                                       ),
//                                     )),
//                               if (numbererror != null)
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 3, bottom: 10.0),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         padding: EdgeInsets.all(0),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                     100,
//                                                 child: Text(
//                                                   "$numbererror",
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 13),
//                                                 )),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               SizedBox(height: 20),
//                               Center(
//                                   child: Container(
//                                 width: 190,
//                                 decoration: BoxDecoration(
//                                     // color: Color.fromARGB(255, 255, 255, 18),
//                                     color: Color.fromARGB(255, 0, 105, 192),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: TextButton(
//                                   onPressed: () async {
//                                     // if (validator()) {
//                                     //   if (numbererror == null) {
//                                     //     OTPrequested == false
//                                     //         // ? verifyPhoneNumber(context)
//                                     //         ? isPhoneNumberStored(
//                                     //             phoneNumber!)
//                                     //         : verifyotp();
//                                     //   }
//                                     // }
//                                     setState(() {
//                                       recaptchaverifying == false;
//                                       OTPrequested == true;
//                                     });
//                                   },
//                                   child: Text(
//                                     OTPrequested == false
//                                         ? 'Get OTP'
//                                         : 'Verify OTP',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                               SizedBox(height: 15),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: 10),
//                         if (numberverified == false)
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                                 '*Please verify your number to continue signup.'),
//                           ),
//                         SizedBox(height: 3),
//                         Center(
//                             child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               // color: Color.fromARGB(255, 255, 255, 18),
//                               color: numberverified == false
//                                   ? Colors.grey
//                                   : Colors.yellow,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: TextButton(
//                             onPressed: () async {
//                               if (numberverified == true) {
//                                 // if (validator()) {
//                                 //   try {
//                                 //     await auth.currentUser!.delete();
//                                 //     final user = await auth
//                                 //         .createUserWithEmailAndPassword(
//                                 //       email: newuserEmail!,
//                                 //       password: newuserPassword,
//                                 //     )
//                                 //         .then((value) {
//                                 //       store.collection('Registered User').add({
//                                 //         'Name': newusername,
//                                 //         'Email': newuserEmail,
//                                 //         'Phone': phoneNumber
//                                 //       });
//                                 //     }).then((value) {
//                                 //       Navigator.pushReplacementNamed(
//                                 //           context, "HomePage");
//                                 //     });
//                                 //   } on FirebaseAuthException catch (e) {
//                                 //     if (e.message ==
//                                 //         'Given String is empty or null') {
//                                 //       {
//                                 //         setState(() {
//                                 //           _error = 'Enter your email';
//                                 //         });
//                                 //       }
//                                 //     } else if (e.message ==
//                                 //         'The email address is badly formatted.') {
//                                 //       {
//                                 //         setState(() {
//                                 //           _error =
//                                 //               'The email address is invalid, please try again.';
//                                 //         });
//                                 //       }
//                                 //     } else {
//                                 //       _error = e.message;
//                                 //     }
//                                 //     print(e);
//                                 //   }
//                                 // }
//                               }
//                               setState(() {});
//                             },
//                             child: Text(
//                               'SIGN UP',
//                               style: TextStyle(
//                                 color: numberverified == true
//                                     ? Colors.black
//                                     : Color.fromARGB(255, 0, 0, 0),
//                               ),
//                             ),
//                           ),
//                         )),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 15),
//                               child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).pushNamed('Login');
//                                   },
//                                   child:
//                                       const Text('Already have an account?')),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 70),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0, top: 25),
//                 child: Column(
//                   children: [
//                     Center(child: Text('Or sign up with social account')),
//                     SizedBox(height: 10),
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextButton(
//                             onPressed: () {},
//                             child: const Image(
//                                 height: 27,
//                                 image: AssetImage('assets/images/google.png')),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Image(
//                                 height: 27,
//                                 image: AssetImage('assets/images/fb.png')),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ]),
//           ),
//         ));
//   }

//   //Error Showing Widget
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
// }
