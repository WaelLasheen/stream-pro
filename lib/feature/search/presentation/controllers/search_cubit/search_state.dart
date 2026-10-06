  import 'package:equatable/equatable.dart';
  import 'package:stream_pro/feature/search/domain/entities/paginated_search_result_entity.dart';

  sealed class SearchState extends Equatable {
    final PaginatedSearchResultEntity? searchResult;
    const SearchState({this.searchResult});
    @override
    List<Object?> get props => [searchResult];
  }

  class SearchInitial extends SearchState {
    const SearchInitial();
  }

  class SearchLoading extends SearchState {
    const SearchLoading();
  }

  class SearchLoaded extends SearchState {
    final bool isLoadingMore;

    const SearchLoaded({
      this.isLoadingMore = false,
      required PaginatedSearchResultEntity super.searchResult,
    });

    @override
    List<Object?> get props => [isLoadingMore, searchResult];
  }

  class SearchFailure extends SearchState {
    final String message;
    const SearchFailure({required this.message, super.searchResult});
    @override
    List<Object?> get props => [message, searchResult];
  }
