import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/delete_profile_use_case.dart';
import '../../../domain/use_cases/get_profile_use_case.dart';
import '../../../domain/use_cases/update_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteProfileUseCase,
  }) : super(const ProfileInitial());

  Future<void> fetchProfile() async {
    emit(const ProfileLoading());

    final result = await getProfileUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> updateProfile({String? name, String? avatarPath}) async {
    final current = state;
    final currentProfile = current.profile;
    if (currentProfile == null) return;
    if (name == null && avatarPath == null) return;
    if (current is ProfileLoaded && current.isSaving) return;

    final optimistic = currentProfile.copyWith(
      name: name,
      avatarUrl: avatarPath,
    );
    emit(ProfileLoaded(profile: optimistic, isSaving: true));

    final result = await updateProfileUseCase(
      name: name,
      avatarPath: avatarPath,
    );
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(ProfileError(message: failure.message, profile: currentProfile)),
      (profile) => emit(ProfileLoaded(profile: profile, isSaving: false)),
    );
  }

  Future<void> deleteAccount() async {
    final current = state;
    final currentProfile = current.profile;
    if (current is ProfileLoaded && current.isDeleting) return;

    if (currentProfile != null) {
      emit(ProfileLoaded(profile: currentProfile, isDeleting: true));
    }

    final result = await deleteProfileUseCase();
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(ProfileError(message: failure.message, profile: currentProfile)),
      (_) => emit(const ProfileDeleted()),
    );
  }
}
