import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class PhoneField extends StatelessWidget {
  const PhoneField(
      {super.key, required this.controller, required this.formKey});
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenSize.width / 30,
        right: ScreenSize.width / 30,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: ScreenSize.width / 50,
              ),
              Text(
                "Phone Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.width / 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Form(
            key: formKey,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Enter your phone number",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenSize.width / 30,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your phone number";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
