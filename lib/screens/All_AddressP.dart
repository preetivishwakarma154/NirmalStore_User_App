import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class All_Address extends StatefulWidget {
  @override
  State<All_Address> createState() => _All_AddressState();
}

var addressData;
Map addressList = Map();
String? selectOption = "0";
int i = 0;

class _All_AddressState extends State<All_Address> {
  Future<void> showAllAddress() async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
        'Cookie': 'ci_session=fb47b67462ef5857dde5857303c1f52f7749e928'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/account/address_list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      addressData = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        setState(() {
          addressList = jsonDecode(addressData);
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    showAllAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "AddAddress");
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            for (i = 0; i < addressList.length; i++) Container(height:MediaQuery.of(context).size.height,child: ListView()),
            SizedBox(
              child: Container(
                  height: 200,
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Radio(
                    value: addressList[i].toString(),
                    groupValue: selectOption,
                    onChanged: (value) {
                      selectOption = value.toString();
                      setState(() {});
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
