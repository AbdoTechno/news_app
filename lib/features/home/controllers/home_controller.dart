import 'package:flutter/material.dart';
import 'package:news/core/datasource/remote_data/api_config.dart';
import 'package:news/core/datasource/remote_data/api_service.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  RequestStatusEnums topHeadLineRequestStatus = RequestStatusEnums.loading;
  RequestStatusEnums everythingRequestStatus = RequestStatusEnums.loading;

  String? errorMessage;
  List<NewsArticleModel> topHeadLinesArticles = [];
  List<NewsArticleModel> everythingArticles = [];
  ApiService apiService = ApiService();
  String? selectedCategory = "Top News";

  void init() {
    getTopHeadLine();
    getEverything();
  }

  Future<void> getTopHeadLine({String? category}) async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadLinesEndPoint,
        endPointsParam: {"country": "us", "category": category?.toLowerCase()},
      );

      topHeadLinesArticles = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineRequestStatus = RequestStatusEnums.success;
      errorMessage = null;
    } on Exception catch (e) {
      topHeadLineRequestStatus = RequestStatusEnums.error;
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
      everythingRequestStatus = RequestStatusEnums.success;
      errorMessage = null;
    } on Exception catch (e) {
      everythingRequestStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }



  void updateSelectedCategory(String category) {
    selectedCategory = category;
    if (category == "Top News") {
      getEverything();
    } else {
      getTopHeadLine(category: category.toLowerCase());
    }
    notifyListeners();
  }
}
