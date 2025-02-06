import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/models/view_models/news_view_model.dart';
import 'package:news_app/views/categories_screen.dart';
import 'package:news_app/views/details_screen.dart';
import 'package:news_app/widgets/general_news_section.dart';
import 'package:news_app/widgets/headings.dart';
import 'package:news_app/widgets/my_drawer.dart';
import 'package:news_app/widgets/spinkit_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, alJazeera, bbcSports }

FilterList? selectedmenu;

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreenContent(),
    CategoriesScreen(),
  ];

  String name = 'bbc-news';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: blue,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        onTap: _onItemTapped, // Handle navigation
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Categories', icon: Icon(Icons.category)),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logowhite.png', height: 120),
        actions: [
          Container(
            height: mq.height * .04,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: blue, blurRadius: 2, offset: Offset(0, 3))
              ],
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  'Select Channel',
                  style: TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                PopupMenuButton<FilterList>(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  initialValue: selectedmenu,
                  icon: Icon(Icons.arrow_drop_down, color: blue),
                  onSelected: (FilterList item) {
                    setState(() {
                      name = item == FilterList.bbcNews
                          ? 'bbc-news'
                          : item == FilterList.aryNews
                              ? 'ary-news'
                              : item == FilterList.alJazeera
                                  ? 'al-jazeera-english'
                                  : 'bbc-sport';
                      selectedmenu = item;
                    });
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: FilterList.bbcNews, child: Text("BBC News")),
                    PopupMenuItem(
                        value: FilterList.aryNews, child: Text("Ary News")),
                    PopupMenuItem(
                        value: FilterList.alJazeera,
                        child: Text("Al Jazeera News")),
                    PopupMenuItem(
                        value: FilterList.bbcSports, child: Text("BBC Sports")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            HeadingsText(text: 'Top Headlines'),
            Expanded(
              child: FutureBuilder<NewsModel>(
                future: newsViewModel.newsRepository(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: mq.height * .55,
                        width: mq.width * .03,
                        child: AppWidgets.SpinkitContainer());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var articles = snapshot.data!.articles;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: mq.height * .75,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: articles!.length,
                              itemBuilder: (context, index) {
                                DateTime datetime = DateTime.parse(
                                    articles[index].publishedAt.toString());
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        newsImage: articles[index].urlToImage ??
                                            "No image",
                                        newsTitle: articles[index].title!,
                                        newsDesc: articles[index].description!,
                                        newsSource:
                                            articles[index].source!.name!,
                                        newsPublishAt: format.format(datetime),
                                        newsAuthor: articles[index].author!,
                                        newsContent: articles[index].content!,
                                        newsArticle: articles[index].url!,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: SizedBox(
                                                height: mq.height * .7,
                                                width: mq.width * .8,
                                                child: CachedNetworkImage(
                                                  imageUrl: articles[index]
                                                      .urlToImage
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      SpinKitCircle(
                                                          color: Colors.black),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 20,
                                              child: Container(
                                                width: mq.width * .7,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      articles[index].title!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            mq.height * .08),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          articles[index]
                                                              .source!
                                                              .name!,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .blue),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          format
                                                              .format(datetime),
                                                          style: GoogleFonts
                                                              .poppins(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          HeadingsText(text: 'General'),
                          SizedBox(
                            height: mq.height * .4,
                            child: FutureBuilder<CategoryModel>(
                              future:
                                  newsViewModel.categoryRepository('General'),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: mq.height * .3,
                                        child: AppWidgets.SpinkitContainer()),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  return generateNewsSection(
                                      context, snapshot, format);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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
