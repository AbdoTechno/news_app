import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/features/home/models/news_article_model.dart';

class BookmarkRepository {
  BookmarkRepository.internal();
  static final BookmarkRepository _instance =
      BookmarkRepository.internal();
  factory BookmarkRepository() => _instance;

  Box<dynamic>? _bookmarkBox;

  Box<dynamic> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception('Bookmark box is not initialized');
    }
    return _bookmarkBox!;
  }

  Future<void> init() async {
    if (!Hive.isBoxOpen(PreferencesKey.bookmarksBox)) {
      _bookmarkBox = await Hive.openBox<dynamic>(
        PreferencesKey.bookmarksBox,
      );
    } else {
      _bookmarkBox = Hive.box<dynamic>(PreferencesKey.bookmarksBox);
    }
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    final url = article.url ?? '';
    if (url.isEmpty) {
      throw Exception('Cannot bookmark article without a valid URL');
    }
    await bookmarkBox.put(url, article.toJson());
  }

  Future<void> removeBookmark(String url) async {
    await bookmarkBox.delete(url);
  }

  Future<List<NewsArticleModel>> getBookmarks() async {
    return bookmarkBox.values
        .where((value) => value is Map)
        .map(
          (value) => NewsArticleModel.fromJson(
            Map<String, dynamic>.from(value as Map),
          ),
        )
        .toList();
  }

  bool isBookmarked(String url) {
    return bookmarkBox.containsKey(url);
  }
}
