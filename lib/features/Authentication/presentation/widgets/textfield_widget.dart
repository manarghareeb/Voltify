import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.title,
      required this.formKey, required this.textInputType});
  final String hintText;
  final TextEditingController controller;
  final String title;
  final GlobalKey<FormState> formKey;
  final TextInputType textInputType;
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
                title,
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
              keyboardType: textInputType,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: ScreenSize.width / 30,
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.width / 35),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your $title';
                } else if (title == "Email" &&
                    value.contains("@gmail.com") == false) {
                  return 'this email is not valid "missing @gmail.com"';
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
