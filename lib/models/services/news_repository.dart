import 'dart:convert';
import 'dart:io'; // Import for SocketException
import 'package:http/http.dart' as http;
import 'package:news_app/utils/data/api_key.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/news_model.dart';

class NewsRepository {
  Future<NewsModel> fetchNewsHeadlinesAPI(String channelName) async {
    try {
      final uri =
          'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=${ApiKey.API_KEY}';

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
      final uri =
          'https://newsapi.org/v2/everything?q=$categoryname&apiKey=${ApiKey.API_KEY}';

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
