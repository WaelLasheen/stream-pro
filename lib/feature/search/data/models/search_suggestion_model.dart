import '../../domain/entities/search_suggestion_entity.dart';

class SearchSuggestionModel {
  final String id;
  final String title;
  final String thumbnailUrl;

  const SearchSuggestionModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    return SearchSuggestionModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
    );
  }

  static List<SearchSuggestionModel> listFromResponse(
    Map<String, dynamic> json,
  ) {
    final videos = json['videos'] as Map<String, dynamic>?;
    final items = videos?['items'] as List<dynamic>? ?? const [];
    return items
        .map((e) => SearchSuggestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  SearchSuggestionEntity toEntity() {
    return SearchSuggestionEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
