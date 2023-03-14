import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';


class MobileLoginWidget extends StatefulWidget {
  const MobileLoginWidget({super.key});

  @override
  State<MobileLoginWidget> createState() => _MobileLoginWidgetState();
}

class _MobileLoginWidgetState extends State<MobileLoginWidget> {
  bool OTPrequested = false;
  var countryselected = '91';
  bool numberverified = false;
  bool? num_already_stored;

  String? numbererror;

  var otp;

  var phoneNumber;
  var onlynumber;

  var authStatus;

  var _verId;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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

  final FirebaseAuth auth = FirebaseAuth.instance;
  var store = FirebaseFirestore.instance;

  bool otpfieldempty = false;

  var otperror;

  bool recaptchaverifying = false;

  //COOLDOWN

  bool cooldown = false;
  var maxseconds = 120;

  bool verifyingfailed = false;

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

  //OTP Error Widget
  Widget showOTPAlert() {
    return Column(
      children: [
        if (otpfieldempty == true)
          Container(
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
          ),
        if (otpfieldempty == false && otperror != null)
          Container(
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
                      "$otperror",
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> verifyPhoneNumber() async {
    try {
      var url = Uri.parse('https://thenirmanstore.com/v1/account/login');
      // print(_googleSignIn.currentUser?.photoUrl.toString());
      var responce = await http.post(url, body: {
        'type': '1',
        'phone': '$phoneNumber',
      });
      var json = jsonDecode(responce.body);
      print(json);
      if (json['status'] == 1) {
        setState(() {
          OTPrequested = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  verifyotp() async {
    if (otp1Controller.text.isNotEmpty ||
        otp2Controller.text.isNotEmpty ||
        otp3Controller.text.isNotEmpty ||
        otp4Controller.text.isNotEmpty ||
        otp5Controller.text.isNotEmpty ||
        otp6Controller.text.isNotEmpty) {
      try {
        var url = Uri.parse('https://thenirmanstore.com/v1/account/otp_verify');
        // print(_googleSignIn.currentUser?.photoUrl.toString());
        var responce = await http.post(url, body: {
          'otp': '$otp',
          'phone': '$phoneNumber',
        });
        var json = jsonDecode(responce.body);
        print(json);
        if (json['status'] == 1) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        otpfieldempty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: maxseconds);
    String formattedTime = formatDuration(duration);
    return recaptchaverifying == false
        ? Form(
            key: _formkey,
            child: Column(
              children: [
                if (verifyingfailed == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Verification Failed, please try again later",
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 15, 22),
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 20),
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                if (OTPrequested == true &&
                    numberverified == false &&
                    verifyingfailed == false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            OTPrequested = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_square,
                              size: 19,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Edit number',
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            'An OTP is sent to your mobile number ${phoneNumber}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp1Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          print('+$otp+');
                                          setState(() {
                                            otpfieldempty = false;
                                            otperror = null;
                                            otp = '${otp1Controller.text}';
                                            if (value.length >= 1) {
                                              otp1FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp2Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          print('+$otp+');
                                          setState(() {
                                            otpfieldempty = false;
                                            otperror = null;
                                            otp =
                                                '${otp1Controller.text}${otp2Controller.text}';
                                            if (value.length >= 1) {
                                              otp2FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                            if (value.length < 1) {
                                              otp2FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp3Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          otpfieldempty = false;
                                          otperror = null;
                                          print('+$otp+');
                                          setState(() {
                                            otp =
                                                '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}';
                                            if (value.length >= 1) {
                                              otp3FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                            if (value.length < 1) {
                                              otp3FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp4Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          otpfieldempty = false;
                                          otperror = null;
                                          print('+$otp+');
                                          setState(() {
                                            otp =
                                                '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
                                            if (value.length >= 1) {
                                              otp4FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                            if (value.length < 1) {
                                              otp4FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp5Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          otpfieldempty = false;
                                          otperror = null;
                                          print('+$otp+');
                                          setState(() {
                                            otp =
                                                '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}';

                                            if (value.length >= 1) {
                                              otp5FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                            if (value.length < 1) {
                                              otp5FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: otp6Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        onChanged: (value) {
                                          otpfieldempty = false;
                                          otperror = null;
                                          print('+$otp+');
                                          setState(() {
                                            otp =
                                                '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}${otp5Controller.text}${otp6Controller.text}';
                                            if (value.length >= 1) {
                                              otp4FocusNode.unfocus();
                                              FocusScope.of(context).unfocus();
                                            }

                                            if (value.length < 1) {
                                              otp5FocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      showOTPAlert(),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cooldown == true) Text(formattedTime),
                          SizedBox(width: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Didn't recieved code?",
                                  style: TextStyle(
                                      color: cooldown
                                          ? Color.fromARGB(160, 158, 158, 158)
                                          : Colors.black)),
                              TextButton(
                                onPressed: () {
                                  if (cooldown == false) {
                                    verifyPhoneNumber();
                                  }
                                },
                                child: Text("Send again",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: cooldown
                                            ? Color.fromARGB(134, 33, 149, 243)
                                            : Colors.blue)),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                if (OTPrequested == false || numberverified == true)
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      // showCountryPicker(
                                      //   context: context,
                                      //   showPhoneCode:
                                      //       true, // optional. Shows phone code before the country name.
                                      //   onSelect: (Country country) {
                                      //     print(
                                      //         'Select country: ${country.displayName}');
                                      //   },
                                      // );
                                      return showCountryPicker(
                                        context: context,
                                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                        // exclude: <String>['KN', 'MF'],
                                        favorite: <String>['IN'],
                                        //Optional. Shows phone code before the country name.

                                        // showWorldWide: false,
                                        onSelect: (country) {
                                          setState(() {
                                            countryselected = country.phoneCode;
                                          });
                                          print(
                                              'Select country: ${country.displayName}');
                                        },
                                        // Optional. Sets the theme for the country list picker.
                                        countryListTheme: CountryListThemeData(
                                          // Optional. Sets the border radius for the bottomsheet.
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                          // Optional. Styles the search field.
                                          inputDecoration: InputDecoration(
                                            labelText: 'Search',
                                            hintText: 'Start typing to search',
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text('+${countryselected}'),
                                          ],
                                        ),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    )),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
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
                                    onChanged: (value) {
                                      print('+$otp+');
                                      setState(() {
                                        numbererror = null;
                                        num_already_stored = null;
                                        // _error = null;
                                        phoneNumber = '+$countryselected$value';
                                        onlynumber = value;
                                        print(phoneNumber);
                                      });
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
                                  ),
                                ),
                              ],
                            ),
                            if (otperror == true)
                              Row(
                                children: [],
                              )
                          ],
                        ),
                      )),
                if (num_already_stored == false)
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
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    "This number is not registered by any account. Please enter a registered number.",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                if (numbererror != null)
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
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    "$numbererror",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                Center(
                    child: Container(
                  width: 190,
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 255, 255, 18),
                      color: Color.fromARGB(255, 0, 105, 192),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () async {
                      OTPrequested == false ? verifyPhoneNumber() : verifyotp();
                    },
                    child: Text(
                      OTPrequested == false ? 'Get OTP' : 'Verify OTP',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 15),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verifying you're not a robot,\nhold tight!",
                    style: TextStyle(
                        color: Color.fromARGB(255, 7, 15, 22),
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 25),
                CircularProgressIndicator.adaptive()
              ],
            ),
          );
  }

  bool validator() {
    if (_formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
