// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsArticleModel {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  factory NewsArticleModel.fromJson(Map<String, dynamic> map) {
    final publishedAtValue = map['publishedAt'];
    DateTime parsedPublishedAt;

    if (publishedAtValue is DateTime) {
      parsedPublishedAt = publishedAtValue;
    } else {
      parsedPublishedAt =
          DateTime.tryParse(publishedAtValue?.toString() ?? "") ??
          DateTime.now();
    }

    return NewsArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'],
      publishedAt: parsedPublishedAt,
      content: map['content'] ?? "",
    );
  }
}
