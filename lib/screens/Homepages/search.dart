import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/categoryprodmodel.dart';
import '../productdetails.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool apicalled = false;
  var prodlist;
  List prodId = [];
  List prodName = [];
  List prodPrice = [];
  List prodImage = [];
  List prodRatings = [];

  List productmodelist = [];
  List searchmodelist = [];

  bool opensearchfield = false;
  Map searchList = Map();

  TextEditingController searchController = TextEditingController();

  var searchdata = false;

  var searchLength;

  var searchNameList = [];
  var idNameList = [];

  var controllerData;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<List> callapi() async {
    print('apicalled');
    var url = Uri.parse('http://thenirmanstore.com/v1/product/products');
    // print(_googleSignIn.currentUser?.photoUrl.toString());
    var responce = await http.post(url, body: {});
    var json = jsonDecode(responce.body);
    setState(() {
      apicalled = true;
    });
    print(apicalled);
    print('json msg printed?');
    print(json['data']);
    var data = await json['data'];
    var datalength = json['data'].length;
    print('Datalength $datalength');

    for (int i = 0; i < datalength; i++) {
      prodId.add(data[i]['id']);
      prodName.add(data[i]['product_name']);
      prodImage.add(data[i]['product_image'][0]['search_image']);
      prodPrice.add(data[i]['price']);
      prodRatings.add(data[i]['product_ratings']);

      // print('x');
    }

    for (int i = 0; i < prodName.length; i++) {
      productmodelist.add(CategoryProductsModel(
        id: prodId[i],
        price: prodPrice[i],
        image: prodImage[i],
        title: prodName[i],
        ratings: 5,
        ratedby: 7,
      ));
    }
    // name = data[0]['name'];
    setState(() {});
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

  Future<void> Search(keyword) async {
    try {
      var headers = {
        'Cookie': 'ci_session=b7d35ec4aeb297701d1f65a735a2716a258f5888'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://thenirmanstore.com/v1/product/products'));
      request.fields.addAll({'keyword': keyword});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          searchList = jsonDecode(data);
        });
        if (searchList['status'] == 1) {
          searchdata = true;
          print(searchList);

          searchLength = searchList['data'].length;
        } else {
          print(searchList);
          print(searchdata);
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    callapi();
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
            leading: opensearchfield == false
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        opensearchfield = false;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      opensearchfield = true;
                    });
                    controllerData = searchController.text.toString();
                    if (controllerData.isEmpty) {
                      controllerData = false;
                    } else {
                      Search(searchController.text.toString());
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              )
            ],
            centerTitle: true,
            title: opensearchfield == false
                ? Text(
                    "Products",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                : TextFormField(
                    onFieldSubmitted: (e) {
                      controllerData = searchController.text.toString();
                      if (controllerData.isEmpty) {
                        controllerData = false;
                      } else {
                        Search(searchController.text.toString());
                      }
                    },
                    controller: searchController,
                    enabled: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search")),
            backgroundColor: Color.fromARGB(255, 249, 248, 248),
            elevation: 0,
          ),
          body: FutureBuilder(
            builder: (BuildContext context, snapshot) {
              return searchList.isNotEmpty && opensearchfield == true
                  ? FutureBuilder(
                      future: Search(searchController.text.toString()),
                      builder: (context, snapshot) {
                        return Container(
                            padding: EdgeInsets.only(top: 10),
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: searchList['status'] == 0
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.cancel_outlined),
                                        SizedBox(width: 8),
                                        Text(
                                          'No Products Found',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : FutureBuilder(
                                    future: Search(
                                        searchController.text.toString()),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                          itemCount: searchList['data'].length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 249, 248, 248),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetails(
                                                                    prodid: searchList[
                                                                            'data']
                                                                        [
                                                                        index]['id'],
                                                                  )));
                                                    },
                                                    child: Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image(
                                                            width: 50,
                                                            image: NetworkImage(
                                                              searchList['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'product_image'][0]
                                                                  [
                                                                  'search_image'],
                                                            )),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              searchList['data']
                                                                      [index][
                                                                  'product_name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue
                                                                      .shade800,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          size: 18,
                                                          color: Colors
                                                              .blue.shade800,
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          });
                                    }));
                      })
                  : Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: GridView.count(
                              // mainAxisSpacing: 5,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 2),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              children: [...productmodelist],
                            ),
                          ),
                        ),
                      ]));
            },
          )),
    );
  }
}
