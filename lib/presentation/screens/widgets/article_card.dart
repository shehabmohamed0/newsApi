import 'package:flutter/material.dart';
import 'package:news/data/models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        child: Column(
          children: [
            if (article.url != null) Image.network(article.url!),
            if (article.url == null)
              FittedBox(
                  child: Image.asset(
                'assets/noImageAvailable.png',
                height: 588,
                width: 980,
              )),
            const SizedBox(
              height: 10,
            ),
            Text(article.title),
            const SizedBox(
              height: 10,
            ),
            Text(article.publishedAt),
          ],
        ),
      ),
    );
  }
}
