import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/view_models/news_view_model.dart';
import 'package:news_app/widgets/general_news_section.dart';
import 'package:news_app/widgets/my_drawer.dart';
import 'package:news_app/widgets/spinkit_container.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final DateFormat format = DateFormat('MMMM dd, yyyy');
  String categories = 'General';

  List<String> categoriesList = [
    'General',
    'Sports',
    'Entertainment',
    'Health',
    'Business',
    'Technology'
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Image(
          image: AssetImage('assets/images/logowhite.png'),
          height: 120,
        ),
      ),
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          categories = categoriesList[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: categories == categoriesList[index]
                              ? Colors.blue.shade800
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              categoriesList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: mq.width * .03,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<CategoryModel>(
                future: newsViewModel.categoryRepository(categories),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppWidgets.SpinkitContainer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return generateNewsSection(context, snapshot, format);
                  } else {
                    return const Center(
                      child: Text('No articles available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
