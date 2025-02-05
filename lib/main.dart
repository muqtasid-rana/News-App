import 'package:flutter/material.dart';
import 'package:news_app/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}
