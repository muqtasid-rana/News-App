import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/views/home_screen.dart';
import 'package:news_app/views/categories_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.white),
            title: Text('Categories', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('About', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutScreen()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
