import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ProfileDetails.dart';
import 'my profile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

late String getData;
Map getList = Map();
var url = 'https://thenirmanstore.com/';

class _MyProfileState extends State<MyProfile> {
  Future<void> getProfile() async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzg0LCJpYXQiOjE2Nzg3OTgwMDB9.D3pd-BAonJ4v09hHIPM4agVw5bPYu5gJzxgVPj9p48M',
        'Cookie': 'ci_session=dc51f8d959bc6201cd8ebc94d6b71a9e04d3cb65'
      };
      var request = http.MultipartRequest('GET',
          Uri.parse('https://thenirmanstore.com/v1/account/get_profile'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      getData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          getList = jsonDecode(getData);
        });
        print(getList);
        print(url + getList['data']['profile_picture']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 35, 15, 20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'My Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 20),
              FutureBuilder(
                builder: (context,snapshot){
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(

                                  )
                          ));
                    },
                    child: getList.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 33,
                            backgroundColor: Colors.white,
                            child: Image(
                              image: NetworkImage(
                                  'https://thenirmanstore.com/' +
                                      getList['data']['profile_picture']),
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              10,
                              10,
                              0,
                              0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getList['data']['username'],
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  getList['data']['email'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },

              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'MyOrder');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'view your orders',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '3 addresses',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment methods',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Visa **34',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'Subscription');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subscription Plans',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'check some exciting plans!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('RefernEarn');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refer and Earn',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Share the link and earn money!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('RefernEarn');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Notifications, password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
