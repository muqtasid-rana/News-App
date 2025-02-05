import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/api_key.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/news_model.dart';

class NewsRepository {
  Future<NewsModel> fetchNewsHeadlinesAPI(String channelName) async {
    final uri =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=${ApiKey.API_KEY}';

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return NewsModel.fromJson(json);
    } else {
      throw Exception("Error during communication");
    }
  }

  Future<CategoryModel> fetchCategoryAPI(String categoryname) async {
    final uri =
        'https://newsapi.org/v2/everything?q=$categoryname&apiKey=${ApiKey.API_KEY}';

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return CategoryModel.fromJson(json);
    } else {
      throw Exception("Error during communication");
    }
  }
}
