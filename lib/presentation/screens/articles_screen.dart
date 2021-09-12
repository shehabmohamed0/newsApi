import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/news_category.dart';
import 'package:news/logic/cubit/article_cubit.dart';
import 'package:news/logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:news/presentation/screens/widgets/articles_list.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
      listener: (context, state) {
        context
            .read<ArticleCubit>()
            .changeCategory(categoryName: state.categoryName);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Bloc'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (categoryIndex) => context
                .read<BottomNavBarCubit>()
                .changeCategory(categoryIndex: categoryIndex),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: NewsCategory.sports,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety),
                label: NewsCategory.health,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: NewsCategory.business,
              ),
            ],
            currentIndex: state.categoryIndex,
          ),
          body: ArticlesList(),
        );
      },
    );
  }
}
