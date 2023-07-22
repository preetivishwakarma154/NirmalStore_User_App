import 'package:flutter/material.dart';

import '../screens/Productsundercategory.dart';

class CategoryModel extends StatefulWidget {
  final id;
  final image;
  final title;
  CategoryModel({
    this.id,
    this.image,
    this.title,
  });

  @override
  State<CategoryModel> createState() => _CategoryModelState();
}

class _CategoryModelState extends State<CategoryModel> {
  @override

  // _CategoryModelState(image, title, ratings, ratedby, price);

  @override
  Widget build(BuildContext context) {
    return //Product list -
        Container(

          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsUnderCategory(category_id: widget.id.toString()),
                ));
          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 120,
                child: Image(image: NetworkImage('${widget.image}')),
              ),
              Center(
                child: Text(

                  // softWrap: true,

                  // textAlign: TextAlign.center,
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          )),
    );
  }
}
