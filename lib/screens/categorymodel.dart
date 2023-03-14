import 'package:flutter/material.dart';


class CategoryModel extends StatefulWidget {
  var image;
  var title;
  CategoryModel({
    this.image,
    this.title,
  });

  @override
  State<CategoryModel> createState() => _CategoryModelState();
}

class _CategoryModelState extends State<CategoryModel> {
  // _CategoryModelState(image, title, ratings, ratedby, price);

  @override
  Widget build(BuildContext context) {
    return //Product list -
        Container(
      child: InkWell(
          child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            child: Image(image: AssetImage('assets/images/prod1.png')),
          ),
          Text(
            'Rental Service',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      )),
    );
  }
}
