part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final int categoryIndex;
  final String categoryName;

  BottomNavBarState(
      {this.categoryIndex = 0, this.categoryName = NewsCategory.sports});

  BottomNavBarState copyWith({
    int? categoryIndex,
  }) =>
      BottomNavBarState(categoryIndex: categoryIndex ?? this.categoryIndex);

  @override
  List<Object?> get props => [categoryIndex, categoryName];
}
