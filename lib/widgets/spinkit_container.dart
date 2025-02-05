import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/main.dart';

class AppWidgets {
  static Widget SpinkitContainer() {
    return Container(
        width: mq.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Center(
          child: SpinKitCircle(
            color: Colors.black,
          ),
        ));
  }
}
