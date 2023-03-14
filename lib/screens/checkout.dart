import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AddAddress.dart';
import 'All_Address.dart';
import 'cart.dart';

class CheckOut extends StatefulWidget {



  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var addressData;
  Map addressList = Map();

  bool apicalled = false;

  Future AllAddress() async {
    try {
      var headers = {
        'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
        'Cookie': 'ci_session=bf1a76db3f3961bcb5e2b119abdd1ac1c3ca4825'
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://thenirmanstore.com/v1/account/address_list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      addressData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          addressList = jsonDecode(addressData);
          apicalled = true;
        });

        return addressList;
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    AllAddress();

    super.initState();
  }

  var delivery_charges = 50;
  Color addAddressColor = Colors.white70;
  Color activeColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
              color: Colors.black, fontSize: 22.5, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Color.fromARGB(255, 249, 248, 248),
        elevation: 0.5,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 27,
              ))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping address',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    if (addressList['status'] == 0) ...[
                      apicalled == true
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onPressed: () {
                                addAddressColor = activeColor;

                                splashColor:
                                Colors.blue.withAlpha(30);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddAddress()));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.blue.shade800,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Add Address',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue.shade800,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ]),
                              )
                              // child: Padding(
                              //   padding: const EdgeInsets.all(15),
                              //   child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               'Jane Doe',
                              //               style: TextStyle(
                              //                   color: Colors.black87,
                              //                   fontSize: 15,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //             InkWell(
                              //               onTap: () {
                              //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>AddAddress() ));
                              //               },
                              //               child: Text(
                              //                 'Change',
                              //                 style: TextStyle(
                              //                     color: Colors.red[600],
                              //                     fontSize: 16),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         SizedBox(height: 10),
                              //         Text('3 Newbridge Court'),
                              //         SizedBox(height: 5),
                              //         Text('Chino Hills, CA 91709, United States'),
                              //       ]),
                              // ),
                              )
                          : SizedBox(
                        height: 70,
                          width: 70,
                          child: CircularProgressIndicator()),
                    ] else ...[
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 246, 246, 246),
                          ),
                          child: Container(
                            width: 200,
                            child: FutureBuilder(
                              future: AllAddress(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {

                                  return Container(
                                    height: 70,

                                    child: ListView.builder(
                                      itemCount: addressList['data'].length,
                                      itemBuilder: (context, index) {

                                      return addressList['data'][index]['default_status']=='1'?Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children:[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(

                                                    addressList['data'][index]
                                                    ['first_name'],
                                                style: TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                All_Address()));
                                                  },
                                                  child: Text(
                                                    'Change',
                                                    style: TextStyle(
                                                        color: Colors.red[600],
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(

                                                snapshot.data['data'][index]
                                                ['address'] +
                                                " " +
                                                snapshot.data['data'][index]
                                                ['city'] +
                                                ", " +
                                                snapshot.data['data'][index]
                                                ['state'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ):Text('');
                                    },),
                                  );
                                }
                                return CircularProgressIndicator.adaptive();
                              },
                            ),
                          ),
                        ),
                      )
                    ],

                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'Payment');
                            },
                            child: Text(
                              'Change',
                              style: TextStyle(
                                  color: Colors.red[600], fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    //Payment
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Image(
                              height: 30,
                              image: AssetImage('assets/images/mastercard.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        Text('**** **** **** 3947')
                      ],
                    )
                  ]),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order:',
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          Row(
                            children: [
                              Text('$price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.currency_rupee_sharp,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery:',
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          Row(
                            children: [
                              Text('$delivery_charges',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.currency_rupee_sharp,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Summary:',
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          Row(
                            children: [
                              Text('${price + delivery_charges}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.currency_rupee_sharp,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 5,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // rgba(211, 38, 38, 0.25);
                              color: Colors.blue[800],
                            ),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('Ordered');
                                },
                                child: Text(
                                  'SUBMIT ORDER',
                                  style: TextStyle(color: Colors.white),
                                ))),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
