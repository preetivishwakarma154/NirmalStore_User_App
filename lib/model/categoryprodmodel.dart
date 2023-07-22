// CART PRODUCT MODEL
import 'package:nirman_store/screens/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:nirman_store/screens/productdetails.dart';


class CategoryProductsModel extends StatefulWidget {
  final id;
  final image;
  final title;
  final ratings;
  final ratedby;
  final price;
  CategoryProductsModel(
      {this.id,
      this.image,
      this.title,
      this.ratings,
      this.ratedby,
      this.price});

  @override
  State<CategoryProductsModel> createState() => _CategoryProductsModelState();
}

class _CategoryProductsModelState extends State<CategoryProductsModel> {
  @override
  void initState() {
print("${widget.id},${widget.price},${widget.title},${widget.image}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return //Product list -

        Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(prodid: widget.id,),));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProductDetails(widget.id)
              //     ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.fitHeight,
                        placeholder: kTransparentImage,
                        image: '${widget.image}',
                      ),
                    ),
                  ),
                  Text(
                    '${widget.title}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     if (widget.ratings > 0)
                  //       Icon(
                  //         Icons.star,
                  //         color: Colors.yellow[700],
                  //         size: 15,
                  //       ),
                  //     if (widget.ratings > 1)
                  //       Icon(
                  //         Icons.star,
                  //         color: Colors.yellow[700],
                  //         size: 15,
                  //       ),
                  //     if (widget.ratings > 2)
                  //       Icon(
                  //         Icons.star,
                  //         color: Colors.yellow[700],
                  //         size: 15,
                  //       ),
                  //     if (widget.ratings > 3)
                  //       Icon(
                  //         Icons.star,
                  //         color: Colors.yellow[700],
                  //         size: 15,
                  //       ),
                  //     if (widget.ratings > 4)
                  //       Icon(
                  //         Icons.star,
                  //         color: Colors.yellow[700],
                  //         size: 15,
                  //       ),
                  //     SizedBox(width: 2),
                  //     Text(
                  //       '(10)',
                  //       style: TextStyle(fontSize: 10, color: Colors.grey),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
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
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
