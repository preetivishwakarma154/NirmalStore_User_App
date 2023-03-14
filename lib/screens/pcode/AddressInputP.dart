import 'package:flutter/material.dart';
class AddressInput extends StatelessWidget {
  const AddressInput( {Key? key, required this.lableText, required this.controller, required this.keyboardType, }) : super(key: key);
  final String lableText;

  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
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
