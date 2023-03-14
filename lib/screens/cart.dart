import 'dart:convert';
import 'checkout.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/productmodel.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

var price = 51;

class _CartState extends State<Cart> {
  bool apicalled = false;
  var quantity = 1;
  var price_initial_value = 51;
  List prodId = [];
  List prodName = [];
  List prodPrice = [];
  List prodImage = [];
  List prodRatings = [];
  List cart_item_id = [];
  List cart_id = [];

  List<Widget> cartlist = [];

  var data;
  var datalength;

  Future<List> callapi() async {
    print('apicalled');
    var url = Uri.parse('http://thenirmanstore.com/v1/cart/cart_in_item');
    // print(_googleSignIn.currentUser?.photoUrl.toString());
    var responce = await http.post(url, body: {}, headers: {
      'x-access-token':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE'
    });

    setState(() {
      apicalled = true;
    });
    var json = jsonDecode(responce.body);
    // print(responce.statusCode);
    print('json msg printed?');
    print(json['data']);
    print(json.length);
    try {} catch (e) {}
    data = json['data'];
    datalength = json['data'].length;

    for (int i = 0; i < datalength; i++) {
      prodId.add(data[i]['id']);
      prodName.add(data[i]['product_name']);
      prodImage.add(data[i]['product_image'][0]['search_image']);
      prodPrice.add(data[i]['price']);
      prodRatings.add(data[i]['product_ratings']);
      cart_item_id.add(data[i]['cart_item_id']);
      cart_id.add(data[i]['cart_id']);
    }

    for (int i = 0; i < prodName.length; i++) {
      cartlist.add(ProductModel(
        // prodid: prodId[i],
        image: prodImage[i],
        title: prodName[i],
        ratings: 4,
        price: prodPrice[i], ratedby: 5, cart_id: cart_id[i],
        cart_item_id: cart_item_id[i],
      ));
    }
    // name = data[0]['name'];
    // setState(() {});
    print(prodName);
    // if (json['status'] == 1) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomePage(),
    //       ));
    // } else {
    //   setState(() {
    //     _error = json['message'];
    //   });
    // }
    return prodName;
  }

  @override
  void initState() {
    callapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CART',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        elevation: 1,
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
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 230, 230, 230),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'View and edit your cart\nor proceed to check out!',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 17),
                    cartlist.isEmpty
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 70.0),
                              child: Column(
                                children: [
                                  if (apicalled == false)
                                    Center(
                                        child: CircularProgressIndicator
                                            .adaptive()),
                                  if (apicalled == true)
                                    Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                              Icons
                                                  .remove_shopping_cart_outlined,
                                              size: 75),
                                          SizedBox(height: 20),
                                          Text(
                                            'Your cart is empty',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : FutureBuilder(
                            future: callapi(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      children: cartlist,
                                    ),
                                  ),
                                );

                              return SizedBox();
                            })
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter your promo code',
                                border: InputBorder.none,
                                suffixIcon: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        )),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total amount:',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                        Row(
                          children: [
                            Text('$price',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.currency_rupee_outlined, size: 17),
                          ],
                        ),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOut()));
                              },
                              child: Text(
                                'CHECK OUT',
                                style: TextStyle(color: Colors.white),
                              ))),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
