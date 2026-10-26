import 'package:equatable/equatable.dart';

class SearchSuggestionEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;

  const SearchSuggestionEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl];
}
