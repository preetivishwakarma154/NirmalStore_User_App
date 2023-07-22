import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key, required this.title, required this.Content}) : super(key: key);
final String title,Content;
  @override
  State<AboutUs> createState() => _AboutUsState();
}



class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
          backgroundColor: Colors.white70,
          title: Text(widget.title,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold))),

      body: SafeArea(
        child: Container(margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('The Nirman Store ',style: TextStyle(
                color: Colors.blue.shade800,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Text(
                widget.Content,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
