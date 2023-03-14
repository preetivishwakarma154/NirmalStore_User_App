import 'package:flutter/material.dart';

class Ordered extends StatefulWidget {
  const Ordered({super.key});

  @override
  State<Ordered> createState() => _OrderedState();
}

class _OrderedState extends State<Ordered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Image(image: AssetImage('assets/images/ordered.png'))),
            SizedBox(height: 20),
            Text(
              'Success!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Your order will be delivered soon!',
              style: TextStyle(fontSize: 13),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Material(
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
                          Navigator.of(context)
                              .pushReplacementNamed('HomePage');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'CONTINUE SHOPPING',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
