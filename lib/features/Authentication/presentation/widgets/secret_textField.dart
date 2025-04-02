import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class SecretTextfield extends StatefulWidget {
  const SecretTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.title,
      required this.formKey});
  final String hintText;
  final TextEditingController controller;
  final String title;
  final GlobalKey<FormState> formKey;

  @override
  State<SecretTextfield> createState() => _SecretTextfieldState();
}

class _SecretTextfieldState extends State<SecretTextfield> {
  bool isobscure = true;
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
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.width / 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Form(
            key: widget.formKey,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: isobscure,
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: ScreenSize.width / 30,
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    isobscure ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isobscure = !isobscure;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.width / 35),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your password";
                } else if (value.length < 6) {
                  return "Password must be at least 6 characters";
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
