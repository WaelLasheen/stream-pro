import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/search_videos_use_case.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchVideosUseCase searchVideosUseCase;

  SearchCubit({required this.searchVideosUseCase})
    : super(const SearchInitial());

  Future<void> search({required String query, String? category}) async {
    String currentQuery = query.trim();

    if (currentQuery.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());

    final result = await searchVideosUseCase(
      SearchVideosParams(query: currentQuery, category: category),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(SearchFailure(message: failure.message)),
      (searchResult) => emit(SearchLoaded(searchResult: searchResult)),
    );
  }

  Future<void> loadMore({required String query, String? category}) async {
    final currentState = state;
    final currentSearchResult = state.searchResult;

    if (currentSearchResult == null || !currentSearchResult.hasNextPage) return;
    if (currentState is SearchLoaded && currentState.isLoadingMore) return;

    emit(SearchLoaded(isLoadingMore: true, searchResult: currentSearchResult));

    final nextPage = currentSearchResult.pageNumber + 1;
    final result = await searchVideosUseCase(
      SearchVideosParams(
        query: query.trim(),
        category: category,
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
    emit(const SearchInitial());
  }
}
