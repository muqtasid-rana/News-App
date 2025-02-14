import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/views/about_view/about_view.dart';
import 'package:news_app/views/home_view/home_screen.dart';
import 'package:news_app/views/categories_view/categories_screen.dart';

class MyDrawer extends StatelessWidget {
  final Function(int)? onItemTapped;
  const MyDrawer({super.key, this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: blue,
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              width: mq.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Image(
                image: AssetImage('assets/images/logoblue.png'),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                onItemTapped!(0);
                Navigator.pop(context);
              }),
          ListTile(
            leading: Icon(Icons.category, color: Colors.white),
            title: Text('Categories', style: TextStyle(color: Colors.white)),
            onTap: () {
              onItemTapped!(1);
            },
          ),
        ],
      ),
    );
  }
}
