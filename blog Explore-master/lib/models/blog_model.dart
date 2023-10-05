// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

List<Blog> blogFromJson(String str) => List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
    Blog({
        this.id,
        this.createdAt,
        this.title,
        this.imageUrl,
    });

    String id;
    DateTime createdAt;
    String title;
    String imageUrl;

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        title: json["title"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "title": title,
        "imageUrl": imageUrl,
    };
}
