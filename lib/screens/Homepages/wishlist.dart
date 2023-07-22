import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/productmodel.dart';
import '../SplashScreen.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  var wish;
  int index = 0;
  Map wishlist = Map();
  bool apicalled = false;

  var wishlistdata;

  Future<void> productWishList() async {
    try {
      var headers = {
        'x-access-token': '$globalusertoken',
        'Cookie': 'ci_session=993f8ce175c6855b3ce46babd7962928f32a41ed'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/product/product_wish'));

      request.headers.addAll(headers);
      //   print('wishlist api called');

      http.StreamedResponse response = await request.send();
      wish = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          wishlist = jsonDecode(wish);
          apicalled = true;
          wishlistdata = wishlist['data'];
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
    return wish;
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Exit'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'WISHLIST',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.5,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: SizedBox(),
          backgroundColor: Color.fromARGB(255, 249, 248, 248),
          elevation: 0.5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                wishlistdata != null
                    ? Expanded(
                        child: FutureBuilder(
                            future: productWishList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: GridView.builder(
                                    itemCount: wishlistdata.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.6),
                                      crossAxisCount:
                                          2, // Set the number of columns in the grid
                                      crossAxisSpacing:
                                          10, // Set the spacing between columns
                                      mainAxisSpacing:
                                          10, // Set the spacing between rows
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProductModel(
                                          api: 'wishlist',
                                          id: wishlist['data'][index]['id'],
                                          image: wishlist['data'][index]
                                                  ['product_image'][0]
                                              ['search_image'],
                                          title: wishlist['data'][index]
                                              ['product_name'],
                                          ratings: wishlist['data'][index]
                                                  ['product_ratings']
                                              .toString(),
                                          price: wishlist['data'][index]
                                              ['price']);
                                    },
                                  ),
                                );

                              if (snapshot.hasError)
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Tap the '),
                                        Icon(Icons.favorite_border),
                                        Text(
                                            ' Icon to add a product in your wishlist!')
                                      ],
                                    ),
                                  ),
                                );
                              return Center(
                                  child: CircularProgressIndicator.adaptive());
                            }),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Column(
                            children: [
                              if (apicalled == false)
                                Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                              if (apicalled == true)
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Tap the '),
                                        Icon(Icons.favorite_border),
                                        Text(
                                            ' Icon to add a product in your wishlist!')
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
