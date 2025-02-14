import 'package:flutter/material.dart';
import 'package:news_app/views/home_view/home_screen.dart';

class SplashViewModel {
  void splashfuture(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
