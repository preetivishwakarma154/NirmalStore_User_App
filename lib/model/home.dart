import 'package:flutter/material.dart';


import '../screens/productdetails.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// var title;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image(
                      fit: BoxFit.cover,
                      alignment: Alignment.topLeft,
                      image: AssetImage('assets/images/poster.jpg')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image(
                        height: 100,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/postertext.png')),
                  ),
                ),
              ],
            ),
          ),
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "You've never seen it before!",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'View all',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),

                      // //Product list -
                      // ProductModel(
                      //   image: 'assets/images/prod1.png',
                      //   price: 2000,
                      //   ratedby: 10,
                      //   ratings: 5,
                      //   title: 'Rental Service',
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    // title = 'Tape Measure';
                                    // prize = 100.00;
                                    // ratings = 4;
                                    // ratedby = 30;
                                    // discription =
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          title: 'Tape Measure',
                                          discription:
                                              "This compact measuring tape is designed to provide instant and accurate measurements. It has a 5m long foldable scale, which provides readings in centimetres, inches and meters. The measuring tape comes in a tough plastic case, which makes it ideal for industrial and professional use.",
                                          prize: 100.00,
                                          ratedby: 30,
                                          ratings: 4,
                                          prodimage: [
                                            'assets/images/products/Tape Measure/TapeMeasure.png',
                                            'assets/images/products/Tape Measure/tapemeasurepic2.jpg',
                                            'assets/images/products/Tape Measure/tapemeasurepic3.jpg'
                                          ],
                                          itemdetails: '''
- This measuring tape is ideal for DIY, domestic and industrial use. It is perfect for measuring short distances & can be operated with one hand
- This compact measuring tape has a 5m-long foldable scale that provides instant & accurate readings in centimetres, inches and meters
- The measuring tape comes with a high-density plastic case, which ensures long-lasting durability. This case makes the tape ideal for heavy duty use. It also protects it from high impacts and accidental falls
- This measuring tape is engineered with an automatic retraction mechanism, which makes it easy and efficient to operate
- The tape features a push lock, which locks the measuring tape while taking measurements. This feature prevents the tape from retracting and enables the user to measure accurately without any inconvenience
- The plastic case is ergonomically designed to provide optimum hand support and grip. The spring mechanism inside enables the user to measure short distances without the need for a helping hand
- The product is manufactured by Stanley Black & Decker with registered trademarks of Stanley, Dewalt & Black+Decker
Limited lifetime warranty offered by manufacturer on the product''',
                                          shippinginfo:
                                              "CASH ON DELIVERY - available \nUPI - available",
                                          support:
                                              "30 days money back guarantee"),
                                    ),
                                  );

                                  // Navigator.pushNamed(
                                  //     context, 'ProductDetails');
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/products/Tape Measure/TapeMeasure.png')),
                                    ),
                                    Text(
                                      'Tape Measure',
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
                                              fontSize: 10, color: Colors.grey),
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
                                      builder: (context) => ProductDetails(
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
                                        support: "30 days money back guarantee",
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
                                              fontSize: 10, color: Colors.grey),
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
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
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
                                        support: "30 days money back guarantee",
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
                                              fontSize: 10, color: Colors.grey),
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
                                      builder: (context) => ProductDetails(
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
                                        support: "30 days money back guarantee",
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
                                              fontSize: 10, color: Colors.grey),
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
                    ]),
              ),
            ],
          ),
        ]))
      ],
    );
  }
}
