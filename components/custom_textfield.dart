import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  bool? isPassword;
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  hintText,
                  style: TextStyle(color: Colors.blue),
                )),
            TextField(
                controller: controller,
                obscureText: isPassword ?? false,
                decoration: InputDecoration(
                  hintText: 'Enter $hintText',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 1)),
                  prefixIcon: Icon(Icons.abc),
                )),
          ],
        ));
  }
}
