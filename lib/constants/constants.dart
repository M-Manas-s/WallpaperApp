import 'package:flutter/material.dart';

TextStyle kIconButtonText =
    TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400);

InputDecoration kLogInInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xff1E1C24),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(10),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(10),
  ),
  border: OutlineInputBorder(),
  hintText: "",
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);
