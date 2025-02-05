import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/views/details_screen.dart';

Widget generateNewsSection(BuildContext context,
    AsyncSnapshot<CategoryModel> snapshot, DateFormat format) {
  var articles = snapshot.data!.articles!;

  return ListView.separated(
    shrinkWrap: true,
    itemCount: articles.length,
    itemBuilder: (context, index) {
      DateTime datetime =
          DateTime.parse(articles[index].publishedAt.toString());
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        newsImage:
                            articles[index].urlToImage ?? "No Image Found",
                        newsTitle: articles[index].title ?? "Title Not Found",
                        newsDesc: articles[index].description ?? "Not Found",
                        newsSource: articles[index].source!.name ?? "Not Found",
                        newsPublishAt: format.format(datetime),
                        newsAuthor: articles[index].author ?? "Not Found",
                        newsContent: articles[index].content ?? "Not Found",
                        newsArticle: articles[index].url ?? "Not Found",
                      )));
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                height: mq.height * 0.2,
                width: mq.width * 0.3,
                imageUrl: articles[index].urlToImage.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) => const SpinKitCircle(
                  color: Colors.black,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: mq.height * .18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        articles[index].title ?? '',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        articles[index].description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            articles[index].source?.name ?? '',
                            style: GoogleFonts.poppins(color: Colors.blue),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            format.format(datetime),
                            style: GoogleFonts.poppins(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(height: 8);
    },
  );
}
