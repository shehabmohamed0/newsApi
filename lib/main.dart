import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repositories/news_repository.dart';
import 'package:news/logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:news/presentation/screens/articles_screen.dart';

import 'logic/cubit/article_cubit.dart';
import 'logic/debug/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ArticleCubit(newsRepository: NewsRepository())..fetchArticles(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ArticlesScreen()),
    );
  }
}
