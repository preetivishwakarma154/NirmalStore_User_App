import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nirman_store/screens/wishlist.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';
import 'dart:async';
import 'dart:convert';
import 'cartprodmodel.dart';
import 'homepage.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails(
      {Key? key,
      this.title,
      this.discription,
      this.prize,
      this.ratedby,
      this.ratings,
      this.prodimage,
      this.itemdetails,
      this.shippinginfo,
      this.support})
      : super(key: key);

  String? title;
  var prize;
  var ratings;
  var ratedby;
  String? discription;
  var prodimage;
  var itemdetails;
  var shippinginfo;
  var support;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool itemdetailsopen = false;
  bool shippinginfoopen = false;
  bool supportopen = false;
  bool favorites = false;
  bool showviewcart = false;
  bool showsplash = false;
  var otperror;
  var data;
  var wishlistData;

  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  Map<String, dynamic> datalist = Map();
  Map<String, dynamic> wishlistDatalist = Map();

  Future<void> getProductDetails(
    String id,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('https://thenirmanstore.com/v1/product/products'));
      request.body = json.encode({"id": id});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      await Future.delayed(Duration(milliseconds: 1500));

      if (response.statusCode == 200) {
        data = await response.stream.bytesToString();
        setState(() {
          datalist = json.decode(data);
        });
        print("!!!!!!!!!!!!!!!!!!!!!!!!" + datalist['data'][3]['product_name']);
        print(datalist);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> productAddWishList(
    product_id,
  ) async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
        'Cookie': 'ci_session=2d0e68281b0950c4d94564b77b855aab995d6f68'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://thenirmanstore.com/v1/product/products_add_wish_list'));
      request.fields.addAll({'product_id': product_id.toString()});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      wishlistData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          wishlistDatalist = json.decode(wishlistData);
        });
        print(wishlistDatalist);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //with a delay of 2000 millisec, the title and logo will appear on the screen.
  productaddedsplash() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    setState(() {
      showsplash = false;
      showviewcart = true;
    });
  }

  DateTime dateTime = DateTime.now();
  String stringdata = '';

  @override
  void initState() {
    getProductDetails(1.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return datalist.isEmpty
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.discreteCircle(
                      color: Colors.blue.shade800, size: 80),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Please wait ")
                ],
              ),
            ),
          )
        : Scaffold(
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
                title: Text(datalist['data'][0]['product_name'],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                actions: [
                  IconButton(
                      onPressed: () {
                        productAddWishList(1);
                      },
                      icon: Icon(
                          wishlistDatalist['status'] == 1
                              ? Icons.favorite_border_outlined
                              : Icons.favorite,
                          color: wishlistDatalist['status'] == 1
                              ? Colors.black
                              : Colors.pink)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share, color: Colors.black))
                ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Image(
                                    width: MediaQuery.of(context).size.width,
                                    height: 270,
                                    image: NetworkImage(datalist['data'][0]
                                        ['product_image'][0]['search_image'])),

                                Image(
                                    height: 270,
                                    image: NetworkImage(datalist['data'][0]
                                        ['product_image'][0]['catalog_image'])),
                                SizedBox(
                                  width: 20,
                                ),
                                Image(
                                    height: 270,
                                    image: NetworkImage(datalist['data'][0]
                                        ['product_image'][0]['cart_image'])),
                                // Image(
                                //     height: 270,
                                //     image: AssetImage(widget.prodimage[3])),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.currency_rupee_outlined,
                                      size: 17.5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(datalist['data'][0]['price'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                  " Discount  " +
                                      datalist['data'][0]['discount_percent']
                                          .toString() +
                                      " %",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(datalist['data'][0]['product_highlights'],
                              style: TextStyle(
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              if (itemdetailsopen == false) {
                                itemdetailsopen = true;
                                setState(() {});
                              } else {
                                itemdetailsopen = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      datalist['data'][0]['short_description'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      itemdetailsopen == false
                                          ? Icons.keyboard_arrow_right_outlined
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: Colors.grey[700],
                                    )
                                  ]),
                            ),
                          ),
                          if (itemdetailsopen == true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Stock " +
                                      datalist['data'][0]['stock'].toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Minimum Order Quantity " +
                                      datalist['data'][0]['min_order_qty']
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Available Products " +
                                      datalist['data'][0]['available']
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Returnable " +
                                      datalist['data'][0]['returnable']
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Varients " +
                                      datalist['data'][0]['variants']
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Product Unit " +
                                      datalist['data'][0]['unit'].toString(),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  datalist['data'][0]['long_description'],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              if (shippinginfoopen == false) {
                                shippinginfoopen = true;
                                setState(() {});
                              } else {
                                shippinginfoopen = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping Info',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      shippinginfoopen == false
                                          ? Icons.keyboard_arrow_right_outlined
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: Colors.grey[700],
                                    )
                                  ]),
                            ),
                          ),
                          if (shippinginfoopen == true)
                            Text(
                              widget.shippinginfo,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          Divider(
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              if (supportopen == false) {
                                supportopen = true;
                                setState(() {});
                              } else {
                                supportopen = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Support',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      supportopen == false
                                          ? Icons.keyboard_arrow_right_outlined
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: Colors.grey[700],
                                    )
                                  ]),
                            ),
                          ),
                          if (supportopen == true)
                            Text(
                              widget.support,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'You can also like this',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '12 items',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              title: 'Saw Blade Case',
                                              discription:
                                                  "These reciprocating saw blades last up to 50% longer* and feature patented tooth forms that deliver fast, smooth cuts in wood and metal-cutting applications. Their Bi-Metal construction is designed to extend blade life and minimizes blade breaks. Each kit contains an assortment of blades for a variety of cutting applications and a collapsible ToughCase® or easy storage. Made in the USA with global materials.",
                                              prize: 100.00,
                                              ratedby: 300,
                                              ratings: 3,
                                              prodimage: [
                                                'assets/images/products/Saw Blade Case/BladeCase.jpg',
                                                'assets/images/products/Saw Blade Case/bladecasepic2.jpg',
                                                'assets/images/products/Saw Blade Case/bladecasepic3.jpg'
                                              ],
                                              itemdetails: '''
- UP TO 50% LONGER LIFE*: Patented tooth forms optimize chip removal for efficient cutting and long life. *Average performance of DEWALT reciprocating saw blade range vs. prior generation DEWALT blades
- STRAIGHT CUTS & INCREASED DURABILITY: Tall, thick blade profile provides straight cuts in heavy metal cutting applications and adds durability for tough demolition applications
- DURABLE BLADE DESIGN: Bi-metal construction delivers blade flexibility and a long-lasting cutting edge
MADE IN THE USA WITH GLOBAL MATERIALS**. ToughCase Container made in China''',
                                              shippinginfo:
                                                  "CASH ON DELIVERY - available \nUPI - available",
                                              support:
                                                  "30 days money back guarantee",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/products/Saw Blade Case/BladeCase.jpg')),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Saw Blade Case',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '(10)',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.currency_rupee_sharp,
                                                  size: 15),
                                              Text(
                                                '2000.00',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  width: 150,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              title: 'Circular Saw',
                                              discription:
                                                  "A circular saw is a tool for cutting many materials such as wood, masonry, plastic, or metal and may be hand-held or mounted to a machine. In woodworking the term 'circular saw' refers specifically to the hand-held type and the table saw and chop saw are other common forms of circular saws.",
                                              prize: 100.00,
                                              ratedby: 300,
                                              ratings: 3,
                                              prodimage: [
                                                'assets/images/products/Circular Saw/CircularSaw.jpg',
                                                'assets/images/products/Circular Saw/circularsawpic2.jpg',
                                                'assets/images/products/Circular Saw/circularsawpic3.png'
                                              ],
                                              itemdetails: '''
[SPECIFICATIONS] Rated voltage : 230V~50Hz; Rated Input Power : 1400 W; Rated no load speed : 4800 rpm; Cutting wheel diameter : 185mm~7.2”; Maximum Cutting Depth : 58 mm; Weight : 5.3 Kg
[GENERAL PURPOSE] CS85-71 is a circular power-saw using a toothed blade to cut materials using a rotary motion spinning around an arbor. This can be used for cutting materials such as wood, masonry, plastic, sometimes light metal.
[EFFICIENT & PRECISE CUTS] This is a powerful and compact tool for cutting that works quite precisely and fast. The cutting wheel(blade) has a position that gives the best reach to the workpiece and improves the efficiency of cutting. The blade is spindle mounted so we can fix and remove it quickly.
[DESIGN] The design allows good control over the angle and the depth of reach at all times. We can make a clean cut so that the end product needs a lesser amount of finishing.
[BIVELLING /ANGLE CUT] The Saw can be adjusted to cut at angles between 0° and 45°. Tilt the body of the tool until the required angle (0°-45°)is reached using the bevel scale as a guide. Pre-set stops are available at 0°, 15° ,30° & 45° for quick, accurate bevel settings.
[RIP FENCE] The Rip fence (Straight edge guide) allows sawing parallel to an edge at a max distance of about 15 cm. Use the guide when making long or wide rip or cross cuts.''',
                                              shippinginfo:
                                                  "CASH ON DELIVERY - available \nUPI - available",
                                              support:
                                                  "30 days money back guarantee",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/products/Circular Saw/CircularSaw.jpg')),
                                          ),
                                          Text(
                                            'Circular Saw',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '(10)',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.currency_rupee_sharp,
                                                  size: 15),
                                              Text(
                                                '2000.00',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  width: 150,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              title: 'Demolition Breaker',
                                              discription:
                                                  "Perfect combination of power, durability and compact design. Material quality is assured to work with long lasting hours with 2 in 1 (drilling and breaking) mechanism and soft rubber grip. The adjustable 360 degree side handle and ergonomic grip handle to give full control.",
                                              prize: 100.00,
                                              ratedby: 300,
                                              ratings: 3,
                                              prodimage: [
                                                'assets/images/products/Demolition Breaker/DemolitionBreaker.jpg',
                                                'assets/images/products/Demolition Breaker/demolitionbreakerpic2.jpg',
                                                'assets/images/products/Demolition Breaker/demolitionbreakerpic3.jpg'
                                              ],
                                              itemdetails: '''
Item Name: Total Demolition Breaker TH213006

- Voltage:220V-240V~50/60Hz
- Input power:1300W
- Impact rate:3800bmp
- Impact force:20J
- Anti-vribration system
- HEX chuck system
- 6Kgs demolation breaker
- With 2pcs chisels
- Packed by BMC
''',
                                              shippinginfo:
                                                  "CASH ON DELIVERY - available \nUPI - available",
                                              support:
                                                  "30 days money back guarantee",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/products/Demolition Breaker/DemolitionBreaker.jpg')),
                                          ),
                                          Text(
                                            'Demolition Breaker',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17.5),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[700],
                                                size: 15,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '(10)',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.currency_rupee_sharp,
                                                  size: 15),
                                              Text(
                                                '2000.00',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                          )
                        ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 20,
                        child: Container(
                            height: 56,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // rgba(211, 38, 38, 0.25);
                              color: showsplash == false
                                  ? Colors.blue[800]
                                  : Colors.white,
                            ),
                            child: TextButton(
                              onPressed: () {
                                // if (showviewcart == false &&
                                //     showsplash == false) {
                                //   cartproducts.add(CartProdModel(
                                //     prodimage: widget.prodimage[0],
                                //     prodname: widget.title,
                                //     prodprice: widget.prize,
                                //   ));
                                //   setState(() {
                                //     showsplash = true;
                                //     showviewcart = false;
                                //   });
                                //   productaddedsplash();
                                // } else if (showviewcart == true &&
                                //     showsplash == false) {
                                //   showsplash = false;
                                //   showviewcart = false;
                                //   selectedIndex = 2;
                                //   Navigator.pushNamed(context,
                                //       'HomePage                                                                                         ');
                                // }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (showviewcart == false &&
                                      showsplash == false)
                                    Text(
                                      'ADD TO CART',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  if (showviewcart == true &&
                                      showsplash == false)
                                    Text(
                                      'VIEW CART',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  if (showviewcart == false &&
                                      showsplash == true)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.done,
                                            color: Colors.green, size: 23),
                                        SizedBox(width: 5),
                                        Text(
                                          'ADDED',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ))),
                  )
                ],
              ),
            ),
          );
  }
}
