import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_app/res/app_urls/app_urls.dart';
import 'package:news_app/utils/data/api_key.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/news_model.dart';

class NewsRepository {
  Future<NewsModel> fetchNewsHeadlinesAPI(String channelName) async {
    try {
      final uri =
          '${AppUrls.topHeadlines}sources=$channelName&apiKey=${ApiKey.API_KEY}';

      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return NewsModel.fromJson(json);
      } else {
        throw Exception("Failed to load news: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No Internet Connection. Please check your network.");
    } on FormatException {
      throw Exception("Invalid response format.");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<CategoryModel> fetchCategoryAPI(String categoryname) async {
    try {
      final uri = '${AppUrls.category}q=$categoryname&apiKey=${ApiKey.API_KEY}';

      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return CategoryModel.fromJson(json);
      } else {
        throw Exception("Failed to load category news: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No Internet Connection. Please check your network.");
    } on FormatException {
      throw Exception("Invalid response format.");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
