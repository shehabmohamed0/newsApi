import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/core/news_category.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState());
  final List<String> categories = [
    NewsCategory.sports,
    NewsCategory.health,
    NewsCategory.business
  ];

  void changeCategory({required int categoryIndex}) {
    emit(BottomNavBarState(
        categoryIndex: categoryIndex, categoryName: categories[categoryIndex]));
  }
}
