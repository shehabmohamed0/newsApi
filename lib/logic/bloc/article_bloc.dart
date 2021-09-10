import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:news/data/data_providers/news_api.dart';
import 'package:news/data/repositories/news_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news/data/models/article.dart';

part 'article_event.dart';

part 'article_state.dart';

const _apiKey = 'ad5fd66639b84f6fab0a3abb846aa9fb';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  NewsRepository newsRepository;

  ArticleBloc({required this.newsRepository}) : super(const ArticleState());

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is ArticleFetchedEvent) {
      yield await _mapArticleFetchedToState(state);
    }
  }

  Future<ArticleState> _mapArticleFetchedToState(ArticleState state) async {
    if (state.hasReachedMax) return state;

    try {
      if (state.status == ArticleStatus.initial) {
        final articles =
            await newsRepository.getArticles(pageIndex: state.page);

        return state.copyWith(
          status: ArticleStatus.success,
          articles: articles,
          page: state.page + 1,
          hasReachedMax: false,
        );
      }
      final articles = await newsRepository.getArticles(pageIndex: state.page);
      return articles.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ArticleStatus.success,
              articles: List.of(state.articles)..addAll(articles),
              page: state.page + 1,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ArticleStatus.failure);
    }
  }

  @override
  Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
      Stream<ArticleEvent> events,
      TransitionFunction<ArticleEvent, ArticleState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
