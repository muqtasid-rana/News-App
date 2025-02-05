import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final String newsImage,
      newsTitle,
      newsDesc,
      newsSource,
      newsPublishAt,
      newsAuthor,
      newsContent,
      newsArticle;

  DetailsScreen({
    super.key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDesc,
    required this.newsSource,
    required this.newsPublishAt,
    required this.newsAuthor,
    required this.newsContent,
    required this.newsArticle,
  });
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image(
          image: AssetImage(
            'assets/images/logowhite.png',
          ),
          height: 120,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image with Gradient Overlay
            Stack(
              children: [
                CachedNetworkImage(
                  height: mq.height * .35,
                  width: mq.width,
                  imageUrl: newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.blue)),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 50, color: Colors.red),
                ),
                Container(
                  height: mq.height * .35,
                  width: mq.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    newsSource,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            // Content Container
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News Title
                  Text(
                    newsTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Author & Published Date
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          newsAuthor.isNotEmpty ? newsAuthor : "Unknown",
                          style: GoogleFonts.poppins(
                            fontSize: mq.height * 0.02, // Adjusted font size
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          newsPublishAt,
                          style: GoogleFonts.poppins(
                            fontSize: mq.height * 0.015, // Adjusted font size
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    newsDesc,
                    style: GoogleFonts.poppins(
                      fontSize: mq.height * 0.02, // Adjusted font size
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    newsContent,
                    style: GoogleFonts.poppins(
                      fontSize: mq.height * 0.02,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade400),

                  // Read Full Article (Optional)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _launchURL(newsArticle);
                      },
                      child: Text(
                        "Read Full Article",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURL(url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
