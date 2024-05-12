import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends CircularProgressIndicator {
  CustomCircularProgressIndicator()
      : super(
    valueColor: AlwaysStoppedAnimation<Color>(
      Colors.green,
    ),
  );
}