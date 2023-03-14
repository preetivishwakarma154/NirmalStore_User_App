import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            "Products",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 249, 248, 248),
          elevation: 0),
      body: Column(children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text('Filters')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.sort_rounded,
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text('Sort')
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: InkWell(
                        child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Image(
                              image: AssetImage('assets/images/prod1.png')),
                        ),
                        Text(
                          'Rental Service',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_sharp, size: 15),
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
                        child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Image(
                              image: AssetImage('assets/images/prod1.png')),
                        ),
                        Text(
                          'Rental Service',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_sharp, size: 15),
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
                        child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Image(
                              image: AssetImage('assets/images/prod1.png')),
                        ),
                        Text(
                          'Rental Service',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_sharp, size: 15),
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
                        child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Image(
                              image: AssetImage('assets/images/prod1.png')),
                        ),
                        Text(
                          'Rental Service',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_sharp, size: 15),
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
            ],
          ),
        )
      ]),
    );
  }
}
