import 'package:flutter/material.dart';
import 'package:news_app/main.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      centerTitle: true,
      title:
          Image.asset('assets/images/logowhite.png', height: mq.height * .14),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
