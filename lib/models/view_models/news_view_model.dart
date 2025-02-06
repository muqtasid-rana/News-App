import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/services/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsModel> newsRepository(String name) async {
    final response = await _repo.fetchNewsHeadlinesAPI(name);
    return response;
  }

  Future<CategoryModel> categoryRepository(String category) async {
    final response = await _repo.fetchCategoryAPI(category);
    return response;
  }
}
