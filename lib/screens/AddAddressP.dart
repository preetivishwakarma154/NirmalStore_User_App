import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'All_AddressP.dart';


class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Future<void> addAddress(full_name, address, city, postcode, state) async {
    try {
      var headers = {
        'x-access-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDIyLCJpYXQiOjE2Nzc5MzMyMzR9.jolwUrSbFTJhhbCXK80I4Qp-OlX47aUHPqkwPj56AoY',
        'Cookie': 'ci_session=fb47b67462ef5857dde5857303c1f52f7749e928'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://thenirmanstore.com/v1/account/add_address'));
      request.fields.addAll({
        'full_name': full_name,
        'address': address,
        'city': city,
        'postcode': postcode,
        'state': state
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
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
                AddressInput("Full Name", nameController),
                AddressInput("Address", addressController),
                AddressInput("City", cityController),
                AddressInput("State/Province/Region", stateController),
                AddressInput("Zip Code (Postal Code)", zipController),
                AddressInput("Country", countryController),
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
                              addAddress(
                                  nameController.text.toString(),
                                  addressController.text.toString(),
                                  cityController.text.toString(),
                                  zipController.text.toString(),
                                  countryController.text.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => All_Address()));
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

  Padding AddressInput(String lableText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: lableText,
                labelStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          )),
    );
  }
}
