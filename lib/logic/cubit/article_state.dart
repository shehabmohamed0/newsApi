part of 'article_cubit.dart';

@immutable
abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleSuccessState extends ArticleState {
  final List<Article> articles;
  final String categoryName;
  final int page;
  final bool hasReachedMax;

  ArticleSuccessState({
    this.articles = const <Article>[],
    this.categoryName = NewsCategory.sports,
    this.page = 1,
    this.hasReachedMax = false,
  });

  ArticleState copyWith({
    List<Article>? articles,
    int? categoryIndex,
    String? categoryName,
    int? page,
    bool? hasReachedMax,
  }) {
    return ArticleSuccessState(
      articles: articles ?? this.articles,
      categoryName: categoryName ?? this.categoryName,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ArticleState { hasReachedMax: $hasReachedMax, posts: ${articles.length} page: $page}''';
  }

  @override
  List<Object?> get props => [articles, categoryName, page, hasReachedMax];
}

class ArticleFailureState extends ArticleState {
  @override
  List<Object?> get props => [];
}
