import 'package:flutter/material.dart';

class CartProdModel extends StatefulWidget {
  var prodimage;
  var prodname;
  var prodprice;
  CartProdModel({this.prodimage, this.prodname, this.prodprice});

  @override
  State<CartProdModel> createState() => _CartProdModelState();
}

class _CartProdModelState extends State<CartProdModel> {
  var quantity = 1;
  var price_initial_value = 51;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 110, image: AssetImage(widget.prodimage)),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.prodname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.more_vert_rounded,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              elevation: 3,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: IconButton(
                                  // remove default padding here
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.remove),
                                  color: Colors.black,
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity -= 1;
                                        widget.prodprice -= price_initial_value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Text('$quantity'),
                            SizedBox(width: 15),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              elevation: 3,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: IconButton(
                                  // remove default padding here
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      quantity += 1;
                                      widget.prodprice += price_initial_value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: 17,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // SizedBox(height: 15),
          //   ],
          // )
        ),
      ),
    );
  }
}
