import 'package:flutter/material.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';
import 'package:news/core/repos/news_repository.dart';
import 'package:news/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixin {
  SearchScreenController(this.newsRepository);
  final BaseNewsRepository newsRepository;
  List<NewsArticleModel> everythingArticles = [];
  RequestStatusEnums everythingRequestStatus = RequestStatusEnums.loading;
  String? errorMessage;
  TextEditingController searchController = TextEditingController();

  Future<void> getEverything() async {
    try {
      everythingRequestStatus = RequestStatusEnums.loading;
      everythingArticles = await newsRepository.getEverything(
        query: searchController.text,
      );
      everythingRequestStatus = RequestStatusEnums.success;
      errorMessage = null;
    } on Exception catch (e) {
      safeNotifyListeners();
      everythingRequestStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotifyListeners();
  }
}
