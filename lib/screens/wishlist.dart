import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/productmodel.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

Map wishlist = Map();

class _WishListState extends State<WishList> {
  var wish;
  int index = 0;

  Future<void> productWishList() async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
        'Cookie': 'ci_session=993f8ce175c6855b3ce46babd7962928f32a41ed'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/product/product_wish'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      wish = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          wishlist = jsonDecode(wish);
        });

        print(wishlist.length);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void delete_product() {
    print('product deleted ');
    setState(() {});
    // wishlist.removeLast();

    setState(() {});
  }

  @override
  void initState() {
    productWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WISHLIST',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (wishlist.isEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tap the '),
                    Icon(Icons.favorite_border),
                    Text(' Icon to add a product in your wishlist!')
                  ],
                ),
              ] else ...[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    itemCount: wishlist['data'].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          2, // Set the number of columns in the grid
                      crossAxisSpacing: 10, // Set the spacing between columns
                      mainAxisSpacing: 10, // Set the spacing between rows
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductModel(
                          image: wishlist['data'][index]['product_image'][0]
                              ['search_image'],
                          title: wishlist['data'][index]['product_name'],
                          ratings: wishlist['data'][index]['product_ratings'].toString(),
                          price: wishlist['data'][index]['price']);
                    },
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
