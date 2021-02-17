// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.excerpt,
    this.content,
    this.publishedAt,
    this.updatedAt,
    this.postId,
    this.postModified,
    this.categoryId,
    this.categoryName,
    this.image,
    this.url,
    this.priority,
    this.order,
  });

  int id;
  String title;
  String excerpt;
  String content;
  int publishedAt;
  int updatedAt;
  String postId;
  String postModified;
  int categoryId;
  String categoryName;
  String image;
  String url;
  String priority;
  String order;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"],
    title: json["title"],
    excerpt: json["excerpt"],
    content: json["content"],
    publishedAt: json["published_at"],
    updatedAt: json["updated_at"],
    postId: json["post_id"],
    postModified: json["post_modified"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    image: json["image"],
    url: json["url"],
    priority: json["priority"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "content": content,
    "published_at": publishedAt,
    "updated_at": updatedAt,
    "post_id": postId,
    "post_modified": postModified,
    "category_id": categoryId,
    "category_name": categoryName,
    "image": image,
    "url": url,
    "priority": priority,
    "order": order,
  };
}
