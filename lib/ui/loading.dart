import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//        color: Colors.green,
        child: Center(
            child: SpinKitChasingDots(
      color: Colors.black.withOpacity(0.85),
      size: 50,
    )));
  }
}
