import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/logic/cubit/article_cubit.dart';

import 'article_card.dart';
import 'bottom_loader.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({Key? key}) : super(key: key);

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();
  late ArticleCubit _articleCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleCubit = context.read<ArticleCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(builder: (context, state) {
      if (state is ArticleFailureState) {
        return const Center(child: const Text('failed to fetch articles'));
      } else if (state is ArticleSuccessState) {
        if (state.articles.isEmpty) {
          return const Center(child: const Text('no articles'));
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index >= state.articles.length
                ? BottomLoader()
                : ArticleCard(article: state.articles[index]);
          },
          itemCount: state.hasReachedMax
              ? state.articles.length
              : state.articles.length + 1,
          controller: _scrollController,
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _articleCubit.fetchArticles();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
