part of 'article_bloc.dart';

enum ArticleStatus { initial, success, failure }

class ArticleState extends Equatable {
  final ArticleStatus status;
  final List<Article> articles;
  final int page;
  final bool hasReachedMax;

  const ArticleState({
    this.status = ArticleStatus.initial,
    this.articles = const <Article>[],
    this.page = 0,
    this.hasReachedMax = false,
  });

  ArticleState copyWith({
    ArticleStatus? status,
    List<Article>? articles,
    int? page,
    bool? hasReachedMax,
  }) {
    return ArticleState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ArticleState { status: $status, hasReachedMax: $hasReachedMax, posts: ${articles.length} page: $page}''';
  }

  @override
  List<Object?> get props => [status, articles, hasReachedMax];
}
