import 'package:flutter/material.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';
import 'package:news/core/repos/bookmark_repository.dart';
import 'package:news/features/home/models/news_article_model.dart';

class BookmarkController extends ChangeNotifier with SafeNotifyMixin {
  BookmarkController(this.bookmarkRepository);

  final BookmarkRepository bookmarkRepository;
  List<NewsArticleModel> bookmarks = [];
  Set<String> bookmarkedUrls = {};
  bool isLoading = true;

  void init() {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    isLoading = true;
    safeNotifyListeners();

    try {
      bookmarks = await bookmarkRepository.getBookmarks();
      bookmarkedUrls = bookmarks
          .where((article) => article.url != null)
          .map((article) => article.url!)
          .toSet();
    } finally {
      isLoading = false;
      safeNotifyListeners();
    }
  }

  bool isBookmarked(NewsArticleModel article) {
    final url = article.url;
    return url != null && bookmarkedUrls.contains(url);
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    final url = article.url;
    if (url == null || url.isEmpty) {
      return;
    }
    await bookmarkRepository.addBookmark(article);
    if (!bookmarkedUrls.contains(url)) {
      bookmarks.insert(0, article);
      bookmarkedUrls.add(url);
      safeNotifyListeners();
    }
  }

  Future<void> removeBookmark(String url) async {
    await bookmarkRepository.removeBookmark(url);
    bookmarks.removeWhere((item) => item.url == url);
    bookmarkedUrls.remove(url);
    safeNotifyListeners();
  }

  Future<void> toggleBookmark(NewsArticleModel article) async {
    final url = article.url;
    if (url == null || url.isEmpty) {
      return;
    }

    if (isBookmarked(article)) {
      await removeBookmark(url);
    } else {
      await addBookmark(article);
    }
  }
}
