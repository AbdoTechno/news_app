import 'package:flutter/material.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';
import 'package:news/features/home/models/news_article_model.dart';
import 'package:news/core/repos/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixin {
  HomeController(this.newsRepository) {
    init();
  }
  RequestStatusEnums topHeadLineRequestStatus = RequestStatusEnums.loading;
  RequestStatusEnums everythingRequestStatus = RequestStatusEnums.loading;

  String? errorMessage;
  List<NewsArticleModel> topHeadLinesArticles = [];
  List<NewsArticleModel> everythingArticles = [];
  String? selectedCategory = "Top News";

  NewsRepository newsRepository;

  void init() {
    getTopHeadLine();
    getEverything();
  }

  Future<void> getTopHeadLine({String? category}) async {
    try {
      topHeadLineRequestStatus = RequestStatusEnums.loading;
      safeNotifyListeners();

      topHeadLinesArticles = await newsRepository.getTopHeadLine(
        category: category?.toLowerCase(),
      );
      safeNotifyListeners();

      topHeadLineRequestStatus = RequestStatusEnums.success;
      errorMessage = null;
    } on Exception catch (e) {
      safeNotifyListeners();

      topHeadLineRequestStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotifyListeners();
  }

  Future<void> getEverything() async {
    try {
      everythingRequestStatus = RequestStatusEnums.loading;

      everythingArticles = await newsRepository.getEverything();

      everythingRequestStatus = RequestStatusEnums.success;
      errorMessage = null;
    } on Exception catch (e) {
      safeNotifyListeners();
      everythingRequestStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    if (category == "Top News") {
      getEverything();
    } else {
      getTopHeadLine(category: category.toLowerCase());
    }
    safeNotifyListeners();
  }
}
