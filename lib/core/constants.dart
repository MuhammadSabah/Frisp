import 'package:flutter/material.dart';

const kOrangeColor = Color(0xffF94701);
const kOrangeColorTint = Color(0xfffa6c34);
const kOrangeColorTint2 = Color(0xfffb7e4d);
const kBlackColor = Color(0xff0E0E0E);
const kGreyColor = Color(0xff232220);

OutlineInputBorder kFocusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade800),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kErrorBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: kGreyColor),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kEnabledBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: kGreyColor),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade800),
  borderRadius: BorderRadius.circular(10),
);
OutlineInputBorder kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);
