import 'dart:convert';

import 'package:http/http.dart' as http;

class News {
  Future<List<NewsData>> fetchNews(
      {bool? science,
      bool? technology,
      bool? all,
      bool? indian,
      bool? business,
      bool? sports,
      bool? world,
      bool? politics,
      bool? startup,
      bool? entertainment,
      bool? miscellaneous,
      bool? hatke,
      bool? automobile}) async {
    Future<List<NewsData>> newsCategory(String category) async {
      List<NewsData> specificNews = [];
      String _url = "https://inshortsapi.vercel.app/news?category=$category";

      Map data =
          jsonDecode((await http.get(Uri.parse(Uri.encodeFull(_url)))).body);

      for (int i = 0; i < data["data"].length; i++) {
        specificNews.add(NewsData(
            author: data['data'][i]['author'],
            category: category,
            content: data['data'][i]['content'],
            date: data['data'][i]['date'],
            imageUrl: data['data'][i]['imageUrl'],
            readMoreUrl: data['data'][i]['readMoreUrl'],
            source: data['data'][i]['url'],
            time: data['data'][i]['time'],
            title: data['data'][i]['title']));
      }
      return specificNews.reversed.toList();
    }

    List<NewsData> news = [];
    if (all ?? false) {
      news += await newsCategory("all");
    } else {
      if (science ?? false) {
        news += await newsCategory("science");
      }
      if (technology ?? false) {
        news += await newsCategory("technology");
      }
      if (indian ?? false) {
        news += await newsCategory("national");
      }
      if (business ?? false) {
        news += await newsCategory("business");
      }
      if (sports ?? false) {
        news += await newsCategory("sports");
      }
      if (world ?? false) {
        news += await newsCategory("world");
      }
      if (politics ?? false) {
        news += await newsCategory("politics");
      }
      if (startup ?? false) {
        news += await newsCategory("startup");
      }
      if (entertainment ?? false) {
        news += await newsCategory("entertainment");
      }
      if (miscellaneous ?? false) {
        news += await newsCategory("miscellaneous");
      }
      if (hatke ?? false) {
        news += await newsCategory("hatke");
      }
      if (automobile ?? false) {
        news += await newsCategory("automobile");
      }
    }
    return news;
  }
}

class NewsData {
  /// returns category of the news (eg: Science)
  final String? category;

  /// returns author of the particular article (eg: Richardo)
  final String? author;

  /// returns the content of the news
  final String? content;

  /// returns date
  final String? date;

  /// returns image link
  final String? imageUrl;

  /// returns readmore link for a deeper dive
  final String? readMoreUrl;

  /// returns time
  final String? time;

  /// returns title of the article
  final String? title;

  /// returns source of the article
  final String? source;

  NewsData(
      {this.category,
      this.author,
      this.content,
      this.date,
      this.imageUrl,
      this.readMoreUrl,
      this.time,
      this.title,
      this.source});
}
