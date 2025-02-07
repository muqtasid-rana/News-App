import 'package:flutter/material.dart';
import 'package:news_app/widgets/my_appbar.dart';
import 'package:news_app/widgets/my_drawer.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Text(
              "Developed by M. Muqtasid Rana",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Text(
              "Email: mmuqtasidrana@gmail.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}
