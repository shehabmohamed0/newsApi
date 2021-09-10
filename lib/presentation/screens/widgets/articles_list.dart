import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/logic/bloc/article_bloc.dart';

import 'article_card.dart';
import 'bottom_loader.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({Key? key}) : super(key: key);

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();
  late ArticleBloc _articleBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = context.read<ArticleBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.failure:
            return const Center(child: Text('failed to fetch articles'));
          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('no articles'));
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
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _articleBloc.add(ArticleFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
