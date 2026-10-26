import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/search/domain/entities/search_suggestion_entity.dart';

sealed class SearchSuggestionsState extends Equatable {
  const SearchSuggestionsState();

  @override
  List<Object?> get props => [];
}

final class SearchSuggestionsInitial extends SearchSuggestionsState {
  const SearchSuggestionsInitial();
}

final class SearchSuggestionsLoading extends SearchSuggestionsState {
  const SearchSuggestionsLoading();
}

final class SearchSuggestionsLoaded extends SearchSuggestionsState {
  final String query;
  final List<SearchSuggestionEntity> suggestions;

  const SearchSuggestionsLoaded({
    required this.query,
    required this.suggestions,
  });

  @override
  List<Object?> get props => [query, suggestions];
}

final class SearchSuggestionsError extends SearchSuggestionsState {
  final String message;

  const SearchSuggestionsError(this.message);

  @override
  List<Object?> get props => [message];
}
