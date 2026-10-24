import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_owner_playlists_use_case.dart';
import 'owner_playlists_state.dart';

class OwnerPlaylistsCubit extends Cubit<OwnerPlaylistsState> {
  final GetOwnerPlaylistsUseCase getOwnerPlaylistsUseCase;

  OwnerPlaylistsCubit({required this.getOwnerPlaylistsUseCase})
    : super(const OwnerPlaylistsInitialState());

  Future<void> fetchOwnerPlaylists({bool showLoading = true}) async {
    if (showLoading) emit(const OwnerPlaylistsLoadingState());

    final result = await getOwnerPlaylistsUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(OwnerPlaylistsErrorState(message: failure.message)),
      (playlists) => emit(OwnerPlaylistsLoadedState(playlists: playlists)),
    );
  }
}
