import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/views/splash_view/splash_view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewModel splash = SplashViewModel();
  @override
  void initState() {
    splash.splashfuture(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image(
        image: AssetImage(
          'assets/images/logowhite.png',
        ),
        width: mq.width * 0.5,
      )),
    );
  }
}
