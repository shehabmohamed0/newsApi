// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:news/data/repositories/news_repository.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:news/data/models/article.dart';
//
// part 'article_event.dart';
//
// part 'article_state.dart';
//
// class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
//   NewsRepository newsRepository;
//
//   ArticleBloc({required this.newsRepository}) : super(const ArticleState());
//
//   @override
//   Stream<ArticleState> mapEventToState(
//     ArticleEvent event,
//   ) async* {
//     if (event is ArticleFetchedEvent) {
//       yield await _mapArticleFetchedToState(state);
//     }
//   }
//
//   Future<ArticleState> _mapArticleFetchedToState(ArticleState state) async {
//     //When returning the same state the bloc does not rebuild
//     if (state.hasReachedMax) return state;
//
//     try {
//       if (state.status == ArticleStatus.initial) {
//         final articles =
//             await newsRepository.getArticles(pageIndex: state.page);
//
//         return state.copyWith(
//           status: ArticleStatus.success,
//           articles: articles,
//           page: state.page + 1,
//           hasReachedMax: false,
//         );
//       }
//       final articles = await newsRepository.getArticles(pageIndex: state.page);
//       /** when we make http request and the response is empty
//        * it means that their is no need to rebuild again
//        * so we stopped article list view from adding new events by
//        * yield the same state but with has reached max = true
//        */
//       return articles.isEmpty
//           ? state.copyWith(hasReachedMax: true)
//           : state.copyWith(
//               status: ArticleStatus.success,
//               articles: List.of(state.articles)..addAll(articles),
//               page: state.page + 1,
//               hasReachedMax: false,
//             );
//     } on Exception {
//       return state.copyWith(status: ArticleStatus.failure);
//     }
//   }
//
//   @override
//   Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
//       Stream<ArticleEvent> events,
//       TransitionFunction<ArticleEvent, ArticleState> transitionFn) {
//     return super.transformEvents(
//         events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
//   }
// }
