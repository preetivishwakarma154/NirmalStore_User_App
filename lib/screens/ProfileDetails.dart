import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nirman_store/screens/my%20profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {Key? key,
    })
      : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String getData;
  Map getList = Map();
  var url = 'https://thenirmanstore.com/';
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

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    // if (pickedFile != null) {
    //  File imageFile = File(
    //       pickedFile.path as List<Object>, ArgumentError.notNull().toString());
    // }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    // if (pickedFile != null) {
    //   File imageFile = File(
    //       pickedFile.path as List<Object>, ArgumentError.notNull().toString());
    // }
  }

  var _value;
  @override
  void initState() {
   getProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: getList['status']==1?Scaffold(
        appBar: AppBar(
            title: Text(
              'PROFILE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.5,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: SizedBox(),
            backgroundColor: Color.fromARGB(255, 249, 248, 248),
            elevation: 0.5,
            actions: [
              PopupMenuButton(
                padding: EdgeInsets.symmetric(horizontal: 25),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (newValue) {
                  if (newValue == 0) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  image: NetworkImage('https://thenirmanstore.com/' +
                                      getList['data']['profile_picture']),
                                  name: getList['data']['username'],
                                  number: getList['data']['phone'],

                                )));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Edit profile"),
                    value: 0,
                  ),
                ],
              )
            ]),
        body: FutureBuilder(
          
          builder: (context,snapshot){
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('https://thenirmanstore.com/' +
                            getList['data']['profile_picture']),
                      ),
                      SizedBox(height: 16),
                      Text(
                        getList['data']['username'],
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getList['data']['email'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Address'),
                  subtitle: Text( getList['data']['city']),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(getList['data']['phone']),
                  ),
                ),
              ],
            );
          },

        ),
      ): Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingAnimationWidget.discreteCircle(
                  color: Color(0xff074d58), size: 80),
              SizedBox(height: 15,),
              Text("Please wait" )
            ],
          ),
        ),
      ),
    );
  }
}
