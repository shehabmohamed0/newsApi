import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String? url;
  final String publishedAt;

  Article({required this.title, required this.url, required this.publishedAt});

  @override
  List<Object?> get props => [title, url, publishedAt];
}
