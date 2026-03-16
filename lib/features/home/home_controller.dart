import 'package:flutter/material.dart';
import 'package:news/core/datasource/remote_data/api_config.dart';
import 'package:news/core/datasource/remote_data/api_service.dart';
import 'package:news/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  bool topHeadLineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  List<NewsArticleModel> topHeadLinesArticles = [];
  List<NewsArticleModel> everythingArticles = [];
  ApiService apiService = ApiService();

  void init() {
    getTopHeadLine();
    getEverything();
  }
  

  Future<void> getTopHeadLine() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadLinesEndPoint,
        endPointsParam: {"country": "us"},
      );

      topHeadLinesArticles = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } on Exception catch (e) {
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everythingEndPoint,
        endPointsParam: {"q": "tesla"},
      );

      everythingArticles =
          (result["articles"] as List?)
              ?.map((e) => NewsArticleModel.fromJson(e))
              .toList() ??
          [];
      everythingLoading = false;
      errorMessage = null;
    } on Exception catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
