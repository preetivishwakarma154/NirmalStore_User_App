import 'package:flutter/material.dart';

import '../screens/productdetailsP.dart';


class ProductModelP extends StatefulWidget {
  ProductModelP(
      {required this.images,
      required this.id,
      required this.title,
      required this.ratings,
      required this.price,
      this.description});
  final images, id;
  final title, ratings, price;
  final description;
  @override
  State<ProductModelP> createState() => _ProductModelPState();
}

class _ProductModelPState extends State<ProductModelP> {
  // _ProductModelPState(image, title, ratings, ratedby, price);

  @override
  Widget build(BuildContext context) {
    return //Product list -

        Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsP(
                    prodid: widget.id,
                  ),
                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 120, width: 120, child: Image.network(widget.images)),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_sharp, size: 15),
                            Text(
                              widget.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () async {
                        print('product deleted ');
                        setState(() {});
                        //await wishlist.removeLast();

                        setState(() {});
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
