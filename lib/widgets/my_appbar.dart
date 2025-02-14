import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/views/home_view/home_screen.dart';

class MyAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
            setState(() {});
          },
          child: Image.asset('assets/images/logowhite.png',
              height: mq.height * .14)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
