import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repositories/news_repository.dart';
import 'package:news/logic/bloc/article_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news/presentation/screens/widgets/articles_list.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Bloc'),
      ),
      body: BlocProvider(
        create: (context) => ArticleBloc(newsRepository: NewsRepository())
          ..add(
            ArticleFetchedEvent(),
          ),
        child: ArticlesList(),
      ),
    );
  }
}
