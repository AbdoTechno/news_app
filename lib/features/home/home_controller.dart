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

  String formatDate(String date) {
    try {
      final formattedDate = DateTime.now().difference(DateTime.parse(date));

      if (formattedDate.inDays > 0) {
        return '${formattedDate.inDays} day${formattedDate.inDays > 1 ? 's' : ''} ago';
      } else if (formattedDate.inHours > 0) {
        return '${formattedDate.inHours} hour${formattedDate.inHours > 1 ? 's' : ''} ago';
      } else if (formattedDate.inMinutes > 0) {
        return '${formattedDate.inMinutes} minute${formattedDate.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown Time';
    }
    
  }
}
