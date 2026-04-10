import 'package:news/core/datasource/remote_data/api_config.dart';
import 'package:news/core/datasource/remote_data/api_service.dart';
import 'package:news/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String? category});

  Future<List<NewsArticleModel>> getEverything({String? query});
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiService);
  final BaseApiService apiService;
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String? category}) async {
    // print("Hash code: ${apiService.hashCode}");
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadLinesEndPoint,
      endPointsParam: {"country": "us", "category": category?.toLowerCase()},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    // print("Hash code: ${apiService.hashCode}");

    Map<String, dynamic> result = await apiService.get(
      ApiConfig.everythingEndPoint,
      endPointsParam: {"q": query},
    );
    return (result["articles"] as List?)
            ?.map((e) => NewsArticleModel.fromJson(e))
            .toList() ??
        [];
  }
}

class MockNewsRepository extends BaseNewsRepository {
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String? category}) async {
    return [
      NewsArticleModel(
        title: "Mock News Article 1",
        description: "This is a mock news article for testing.",
        urlToImage: "https://via.placeholder.com/150",
        publishedAt: DateTime.now(),
        author: '',
        url: '',
        content: '',
      ),
      NewsArticleModel(
        title: "Mock News Article 2",
        description: "This is another mock news article for testing.",
        urlToImage: "https://via.placeholder.com/150",
        publishedAt: DateTime.now(),
        author: '',
        url: '',
        content: '',
      ),
    ];
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    return [
      NewsArticleModel(
        title: "Mock News Article 3",
        description: "This is a mock news article for testing.",
        urlToImage: "https://via.placeholder.com/150",
        publishedAt: DateTime.now(),
        author: '',
        url: '',
        content: '',
      ),
      NewsArticleModel(
        title: "Mock News Article 4",
        description: "This is another mock news article for testing.",
        urlToImage: "https://via.placeholder.com/150",
        publishedAt: DateTime.now(),
        author: '',
        url: '',
        content: '',
      ),
    ];
  }
}
