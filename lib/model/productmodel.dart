// CART PRODUCT MODEL

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductModel extends StatefulWidget {
  var image;
  var title;
  var ratings;
  var ratedby;
  var price;
  var cart_item_id;
  var cart_id;
  ProductModel(
      {this.image,
      this.title,
      this.ratings,
      this.ratedby,
      this.price,
      this.cart_item_id,
      this.cart_id});

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  var data;
  var datalength;

  bool apicalled = false;

  void callapi() async {
    print('apicalled');
    var url = Uri.parse('http://thenirmanstore.com/v1/cart/delete_cart_item');
    // print(_googleSignIn.currentUser?.photoUrl.toString());
    var responce = await http.post(url, body: {
      'cart_item_id': widget.cart_item_id,
      'cart_id': widget.cart_id
    }, headers: {
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
    try {
      data = json['data'];
      datalength = json['data'].length;
    } catch (e) {
      print(e);
    }
    // return json;
  }

  @override
  Widget build(BuildContext context) {
    return //Product list -

        Stack(
      children: [
        Container(
          child: InkWell(
              child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                child: Image(image: NetworkImage('${widget.image}')),
              ),
              Text(
                '${widget.title}',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_rupee_sharp, size: 15),
                  Text(
                    '2000.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () async {
                callapi();
                setState(() {});
              },
              child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  )),
            ))
      ],
    );
  }
}
