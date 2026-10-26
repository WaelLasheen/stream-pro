import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/search_suggestion_entity.dart';
import '../repositories/search_repository.dart';

class GetSearchSuggestionsUseCase {
  final SearchRepository repository;

  GetSearchSuggestionsUseCase(this.repository);

  Future<Either<Failure, List<SearchSuggestionEntity>>> call(String query) {
    return repository.getSuggestions(query);
  }
}
