import 'package:flutter/foundation.dart';

@immutable
class News {
  const News({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.isBookmarked = false,
  });

  final NewsSource source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final bool isBookmarked;

  News copyWith({
    NewsSource? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    bool? isBookmarked,
  }) {
    return News(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  factory News.fromJson(Map<dynamic, dynamic> json) {
    return News(
      source: NewsSource.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'isBookmarked': isBookmarked,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is News &&
        source == other.source &&
        author == other.author &&
        title == other.title &&
        description == other.description &&
        url == other.url &&
        urlToImage == other.urlToImage &&
        publishedAt == other.publishedAt &&
        content == other.content &&
        isBookmarked == other.isBookmarked;
  }

  @override
  int get hashCode => Object.hash(
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        isBookmarked,
      );
}

@immutable
class NewsSource {
  const NewsSource({this.id, required this.name});

  final int? id;
  final String name;

  factory NewsSource.fromJson(Map<dynamic, dynamic> json) {
    return NewsSource(
      id: int.tryParse(json['id'] ?? ''),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
