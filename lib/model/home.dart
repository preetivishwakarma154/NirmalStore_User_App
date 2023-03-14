import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'categorymodel.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List prodName = [];
  List prodImage = [];
  List prodId = [];
  List categorymodelist = [];
  Future<List> callapi() async {
    print('apicalled');
    var url = Uri.parse('https://thenirmanstore.com/v1/home/categories');
    // print(_googleSignIn.currentUser?.photoUrl.toString());
    var responce = await http.get(
      url,
    );
    var json = jsonDecode(responce.body);
    // print(responce.statusCode);
    print('json msg printed?');
    print(json['data']);
    print(json.length);
    var data = json['data'];
    var datalength = json.length;

    for (int i = 0; i < datalength; i++) {
      prodName.add(data[i]['name']);
      prodImage.add(data[i]['image_file']);
      prodId.add(data[i]['id']);

      // print('x');
    }

    for (int i = 0; i < prodName.length; i++) {
      categorymodelist.add(CategoryModel(
        id: prodId[i],
        image: prodImage[i],
        title: prodName[i],
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

  @override
  void initState() {
    callapi();
    print('object');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Stack(alignment: Alignment.bottomRight, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image(
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
                image: AssetImage('assets/images/poster.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image(
                  height: 100,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/postertext.png')),
            ),
          ),
        ]),
        SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Select a category to view it's products!",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Text(
                      //     'View all',
                      //     style: TextStyle(
                      //         fontSize: 13, fontWeight: FontWeight.bold),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(height: 20),
                  categorymodelist.isNotEmpty
                      ? GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: [...categorymodelist],
                        )
                      : Container(
                          height: 300,
                          child: Center(
                              child: CircularProgressIndicator.adaptive())),
                ]),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
