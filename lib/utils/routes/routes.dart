import 'package:flutter/material.dart';
import 'package:news_app/utils/routes/route_names.dart';
import 'package:news_app/views/categories_view/categories_screen.dart';
import 'package:news_app/views/home_view/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homescreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteNames.categoryscreen:
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}
