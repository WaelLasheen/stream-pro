import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/search_videos_use_case.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchVideosUseCase searchVideosUseCase;

  Timer? _debounceTimer;

  SearchCubit({required this.searchVideosUseCase})
    : super(const SearchInitial());

  void onQueryChanged({required String query, required String? categoryId}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _search(query: query, categoryId: categoryId);
    });
  }

  Future<void> _search({required String query, String? categoryId}) async {
    String currentQuery = query.trim();

    if (currentQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchVideosUseCase(
      SearchVideosParams(query: currentQuery, categoryId: categoryId),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(SearchFailure(message: failure.message)),
      (searchResult) => emit(SearchLoaded(searchResult: searchResult)),
    );
  }

  Future<void> loadMore({required String query, String? categoryId}) async {
    final currentState = state;
    final currentSearchResult = state.searchResult;
    if (currentSearchResult == null || !currentSearchResult.hasNextPage) return;
    if (currentState is SearchLoaded && currentState.isLoadingMore) return;

    emit(SearchLoaded(isLoadingMore: true, searchResult: currentSearchResult));

    final nextPage = currentSearchResult.pageNumber + 1;
    final result = await searchVideosUseCase(
      SearchVideosParams(
        query: query.trim(),
        categoryId: categoryId,
        pageNumber: nextPage,
      ),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        SearchFailure(
          message: failure.message,
          searchResult: currentSearchResult,
        ),
      ),
      (newSearchResult) => emit(
        SearchLoaded(
          searchResult: newSearchResult.copyWith(
            items: [...currentSearchResult.items, ...newSearchResult.items],
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }

  void clearSearch() {
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
