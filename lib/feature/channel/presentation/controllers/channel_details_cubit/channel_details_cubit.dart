import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_channel_details_use_case.dart';
import 'channel_details_state.dart';

class ChannelDetailsCubit extends Cubit<ChannelDetailsState> {
  final GetChannelDetailsUseCase getChannelDetailsUseCase;

  ChannelDetailsCubit({required this.getChannelDetailsUseCase})
    : super(const ChannelDetailsInitialState());

  Future<void> fetchChannelDetails(String channelId) async {
    emit(const ChannelDetailsLoadingState());

    final result = await getChannelDetailsUseCase(channelId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ChannelDetailsErrorState(message: failure.message)),
      (details) => emit(ChannelDetailsLoadedState(details: details)),
    );
  }
}
