import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/feature/search/domain/use_cases/get_search_suggestions_use_case.dart';
import 'search_suggestions_state.dart';

class SearchSuggestionsCubit extends Cubit<SearchSuggestionsState> {
  final GetSearchSuggestionsUseCase getSearchSuggestionsUseCase;
  static const int minQueryLength = 2;
  Timer? _debounceTimer;

  String _latestQuery = '';

  SearchSuggestionsCubit({required this.getSearchSuggestionsUseCase})
    : super(const SearchSuggestionsInitial());

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _latestQuery = query.trim();

    if (_latestQuery.length < minQueryLength) {
      emit(const SearchSuggestionsInitial());
      return;
    }

    final queryToFetch = _latestQuery;
    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () => _fetch(queryToFetch),
    );
  }

  Future<void> retry() async {
    if (_latestQuery.length < minQueryLength) return;
    await _fetch(_latestQuery);
  }

  Future<void> _fetch(String query) async {
    if (state is! SearchSuggestionsLoaded) {
      emit(const SearchSuggestionsLoading());
    }

    final result = await getSearchSuggestionsUseCase(query);
    if (isClosed || query != _latestQuery) return;
    result.fold(
      (failure) => emit(SearchSuggestionsError(failure.message)),
      (suggestions) =>
          emit(SearchSuggestionsLoaded(query: query, suggestions: suggestions)),
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
