import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/main.dart';

class HeadingsText extends StatelessWidget {
  final String text;
  const HeadingsText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.alata(
          color: Colors.black,
          fontSize: mq.width * .05,
          fontWeight: FontWeight.bold),
    );
  }
}
