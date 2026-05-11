import 'package:flutter/material.dart';
import 'package:news/core/widgets/artical_card.dart';
import 'package:news/features/bookmark/bookmark_controller.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Bookmarks')),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.bookmarks.isEmpty
              ? const Center(child: Text('No bookmarks yet.'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: controller.bookmarks.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final article = controller.bookmarks[index];
                    return ArticleCard(
                      article: article,
                      onBookmarkTap: (newsArticle) {
                        controller.toggleBookmark(newsArticle);
                      },
                      isBookmarked: true,
                    );
                  },
                ),
        );
      },
    );
  }
}
