// To parse this JSON data, do
//
//     final headlinesModel = headlinesModelFromJson(jsonString);

import 'dart:convert';

HeadlinesModel headlinesModelFromJson(String str) => HeadlinesModel.fromJson(json.decode(str));

String headlinesModelToJson(HeadlinesModel data) => json.encode(data.toJson());

class HeadlinesModel {
  HeadlinesModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory HeadlinesModel.fromJson(Map<String, dynamic> json) => HeadlinesModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source!.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt!.toIso8601String(),
    "content": content,
  };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] == null ? null : json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name,
  };
}


class Articles {
  List<Article> articles;

  Articles(this.articles);
  factory Articles.fromJson(List<dynamic> parsed) {
    List<Article> articles = <Article>[];
    articles = parsed.map((i) => Article.fromJson(i)).toList();
    return new Articles(articles);
  }
}