import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_channel_home_use_case.dart';
import 'channel_home_tab_state.dart';

class ChannelHomeTabCubit extends Cubit<ChannelHomeTabState> {
  final GetChannelHomeUseCase getChannelHomeUseCase;

  ChannelHomeTabCubit({required this.getChannelHomeUseCase})
    : super(const ChannelHomeTabInitialState());

  Future<void> fetchChannelHome(String channelId) async {
    emit(const ChannelHomeTabLoadingState());

    final result = await getChannelHomeUseCase(channelId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ChannelHomeTabErrorState(message: failure.message)),
      (home) => emit(ChannelHomeTabLoadedState(home: home)),
    );
  }
}
