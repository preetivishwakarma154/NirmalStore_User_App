// CART PRODUCT MODEL

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductModel extends StatefulWidget {
  final api;
  final id;
  final image;
  final title;
  final ratings;
  final ratedby;
  final price;
  final cart_item_id;
  final cart_id;

  ProductModel(
      {required this.api,
      this.id,
      this.image,
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

  void deletefromwishlist() async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDIyLCJpYXQiOjE2Nzc5MzMyMzR9.jolwUrSbFTJhhbCXK80I4Qp-OlX47aUHPqkwPj56AoY',
        'Cookie': 'ci_session=e8daebc9c3fe6cc93fdf999ed4c5457e27b5c185'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://thenirmanstore.com/v1/product/delete_wish_list_product'));
      request.fields.addAll({'product_id': widget.id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    // return json;
  }

  void deletefromcart(cart_item_id, cart_id) async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDIyLCJpYXQiOjE2Nzc5MzMyMzR9.jolwUrSbFTJhhbCXK80I4Qp-OlX47aUHPqkwPj56AoY',
        'Cookie': 'ci_session=e8daebc9c3fe6cc93fdf999ed4c5457e27b5c185'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/cart/delete_cart_item'));
      request.fields.addAll({'cart_item_id': cart_item_id, 'cart_id': cart_id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
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
            child: CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    if (widget.api == 'wishlist') {
                      deletefromwishlist();
                    }
                    if (widget.api == 'cart') {
                      deletefromcart(widget.cart_item_id, widget.cart_id);
                    }
                  },
                )))
      ],
    );
  }
}
