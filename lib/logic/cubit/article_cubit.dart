import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:news/core/news_category.dart';
import 'package:news/data/models/article.dart';
import 'package:news/data/repositories/news_repository.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  NewsRepository newsRepository;

  ArticleCubit({required this.newsRepository}) : super(ArticleInitialState());

  Future<void> fetchArticles() async {
    try {
      if (state is ArticleInitialState) {
        final articles = await newsRepository.getArticles(
            pageIndex: 1, category: NewsCategory.sports);

        emit(ArticleSuccessState(articles: articles, page: 2));
      }

      if (state is ArticleSuccessState) {
        final currentState = state as ArticleSuccessState;
        final articles = await newsRepository.getArticles(
            pageIndex: currentState.page, category: NewsCategory.sports);

        articles.isEmpty
            ? emit(currentState.copyWith(hasReachedMax: true))
            : emit(currentState.copyWith(
                articles: List.of(currentState.articles)..addAll(articles),
                page: currentState.page + 1,
                hasReachedMax: false,
              ));
      }
    } on Exception {}
  }

  void changeCategory({required String categoryName}) async {
    emit(ArticleInitialState());
    final articles =
        await newsRepository.getArticles(pageIndex: 1, category: categoryName);
    emit(
        ArticleSuccessState(articles: articles, page: 2, hasReachedMax: false));
  }

  void dispose() {
    close();
  }
}
