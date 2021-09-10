import 'package:news/data/data_providers/news_api.dart';
import 'package:news/data/models/article.dart';

class NewsRepository {
  NewsApi _newsApi = NewsApi.instance;

  Future<List<Article>> getArticles({required int pageIndex}) async {
    return (await _newsApi.fetchArticles(pageIndex: pageIndex))
        .map((dynamic json) {
      return Article(
          title: json['title'] as String,
          url: json['urlToImage'] as String?,
          publishedAt: json['publishedAt'] as String);
    }).toList();
  }
}
