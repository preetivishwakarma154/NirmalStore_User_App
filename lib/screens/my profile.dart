import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nirman_store/screens/ProfileDetails.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key, required this.image, required this.name, required this.number})
      : super(key: key);
  var name, number;
  NetworkImage image;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _image;
  Map datalist = Map();

  final picker = ImagePicker();
  Future<void> Edit_Profile(username, phone, image) async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDIyLCJpYXQiOjE2Nzc5MzMyMzR9.jolwUrSbFTJhhbCXK80I4Qp-OlX47aUHPqkwPj56AoY'
      };
      print('++++++++++++++++++++++' + image);
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/account/edit_profile'));
      request.fields.addAll({'username': username, 'phone': phone});
      request.files
          .add(await http.MultipartFile.fromPath('profile_picture', image));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          datalist = jsonDecode(data);
        });
        if (datalist['status'] == 1) {

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(

              )));
        }else{
          CircularProgressIndicator();
        }
        print(datalist);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.name;
    numberController.text = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _getImage(ImageSource source) async {
      final pickedFile = await picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    void _updateProfile(name, phoneNumber) {
      setState(() {
        widget.name = name;
        widget.number = phoneNumber;
      });
    }

    return SafeArea(
      child: Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Gallery'),
                                    onTap: () {
                                      _getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text('Camera'),
                                    onTap: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image == null
                        ? widget.image as ImageProvider
                        : FileImage(_image) as ImageProvider
                    //_image==null? FileImage(_image!):AssetImage('assets/images/fb.png')as ImageProvider
                    ,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    widget.name = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    widget.number = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                            var image;
                           _image==null?image=widget.image:image=_image;
                            Edit_Profile(nameController.text.toString(),
                                numberController.text.toString(), image.path);
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
