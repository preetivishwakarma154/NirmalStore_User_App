import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AddressInput.dart';
import 'All_Address.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({ required this.Name, required this.Address, required this.City, required this.state, required this.ZipCode, required this.Id});
  final String Id,Name,Address,City,state;
  final String ZipCode;


  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}
Future<void> updateAddress(address_id,
    full_name,
    address,
    city,
    postcode,
    state) async {
  try{
    var headers = {
      'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
      'Cookie': 'ci_session=7d4832524981a8c354021e32be4b985be19526ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://thenirmanstore.com/v1/account/update_address'));
    request.fields.addAll({
      'address_id': address_id,
      'full_name': full_name,
      'address': address,
      'city': city,
      'postcode': postcode,
      'state':state
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  } catch (e) {
    print(e.toString());
  }
}
class _UpdateAddressState extends State<UpdateAddress> {
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
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mzk3LCJpYXQiOjE2Nzc3NzI4NDB9.MsjQ4H2x6wPyqNEzTMqBP-x4cgwNwt_1E4SZ5ZxIYZE',
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
  void initState() {
    nameController.text = widget.Name;
    addressController.text = widget.Address;
    cityController.text= widget.City;
    stateController.text= widget.state;
    zipController.text= widget.ZipCode.toString();

    super.initState();
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
                  lableText: "Full Name", controller: nameController,keyboardType: TextInputType.name,),
                AddressInput(
                    lableText: "Address", controller: addressController,keyboardType: TextInputType.name),
                AddressInput(lableText: "City", controller: cityController,keyboardType: TextInputType.name),
                AddressInput(lableText: "Zip Code (Postal Code)",
                    controller: zipController,keyboardType: TextInputType.number),
                AddressInput(lableText: "State/Province/Region",
                    controller: stateController,keyboardType: TextInputType.name),


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

                              updateAddress(widget.Id,nameController.text.toString(),
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


}
