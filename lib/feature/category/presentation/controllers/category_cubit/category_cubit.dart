import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_categories_use_case.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit(this.getCategoriesUseCase) : super(const CategoryInitial());

  Future<void> fetchCategories() async {
    emit(const CategoryLoading());

    final result = await getCategoriesUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
