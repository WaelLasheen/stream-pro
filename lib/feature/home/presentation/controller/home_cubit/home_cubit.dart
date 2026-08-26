import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_feed_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFeedUseCase getFeedUseCase;

  HomeCubit({required this.getFeedUseCase}) : super(const HomeInitialState());

  Future<void> fetchFeed() async {
    emit(const HomeLoadingState());

    final result = await getFeedUseCase();

    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (sections) => emit(HomeLoadedState(sections)),
    );
  }
}