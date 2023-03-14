import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../All_AddressP.dart';
import 'AddressInputP.dart';


class AddAddressP extends StatefulWidget {
  const AddAddressP({super.key});

  @override
  State<AddAddressP> createState() => _AddAddressPState();
}

class _AddAddressPState extends State<AddAddressP> {
  var valuefirst = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Map datalsit = Map();

  Future<void> AddAddressP(
      full_name, address, city, postcode, state, Default) async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
        'Cookie': 'ci_session=a2760103c1db7333b86a6695935e543a2d6ad0b8'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/account/add_address'));
      request.fields.addAll({
        'full_name': 'mukeshhhf',
        'address': 'hardahhdv',
        'city': 'hardahhff',
        'postcode': '46144145',
        'state': 'mp',
        'default': '1'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          datalsit = jsonDecode(data);
        });
        if (datalsit['status'] == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => All_Address()));
        } else {
          var snackBar =
              SnackBar(content: Text('This address is already exits'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        print(datalsit);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 238, 238),
      appBar: AppBar(
        title: Text(
          'Add Shipping Address',
          style: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Color.fromARGB(255, 249, 248, 248),
        elevation: 0.5,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 27,
              ))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(children: [
                AddressInput(
                  lableText: "Full Name",
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                AddressInput(
                    lableText: "Address",
                    controller: addressController,
                    keyboardType: TextInputType.name),
                AddressInput(
                    lableText: "City",
                    controller: cityController,
                    keyboardType: TextInputType.name),
                AddressInput(
                    lableText: "Zip Code (Postal Code)",
                    controller: zipController,
                    keyboardType: TextInputType.number),
                AddressInput(
                    lableText: "State/Province/Region",
                    controller: stateController,
                    keyboardType: TextInputType.name),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue.shade800,
                  title: const Text(' Set as default address'),
                  value: this.valuefirst,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valuefirst = value!;
                    });
                    visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                              var checkboxValue;
                              if (valuefirst == true) {
                                checkboxValue = 1;
                              } else {
                                checkboxValue = 0;
                              }

                              print(valuefirst);

                              AddAddressP(
                                  nameController.text.toString(),
                                  addressController.text.toString(),
                                  cityController.text.toString(),
                                  zipController.text.toString(),
                                  countryController.text.toString(),
                                  checkboxValue.toString());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => All_Address()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'SAVE ADDRESS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
