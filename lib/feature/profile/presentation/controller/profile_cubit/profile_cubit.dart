import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/feature/auth/domain/use_case/logout_use_case.dart';
import '../../../domain/use_cases/delete_profile_use_case.dart';
import '../../../domain/use_cases/get_profile_use_case.dart';
import '../../../domain/use_cases/update_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final SessionCleanupService sessionCleanupService;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteProfileUseCase,
    required this.logoutUseCase,
    required this.sessionCleanupService,
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
    if (current is ProfileLoaded && current.isSaving) return;

    final trimmedName = name?.trim();
    final nameChanged =
        trimmedName != null &&
        trimmedName.isNotEmpty &&
        trimmedName != currentProfile.name;

    if (!nameChanged && avatarPath == null) return;

    final optimistic = currentProfile.copyWith(
      name: nameChanged ? trimmedName : null,
    );
    emit(ProfileLoaded(profile: optimistic, isSaving: true));

    final result = await updateProfileUseCase(
      name: nameChanged ? trimmedName : null,
      avatarPath: avatarPath,
    );
    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(ProfileError(message: failure.message, profile: currentProfile)),
      (profile) => emit(
        ProfileLoaded(
          profile: currentProfile.copyWith(
            name: profile.name,
            avatarUrl: profile.avatarUrl,
          ),
          isSaving: false,
        ),
      ),
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

    if (result.isLeft()) {
      final message = result.fold((failure) => failure.message, (_) => '');
      emit(ProfileError(message: message, profile: currentProfile));
      return;
    }

    await sessionCleanupService.clearSession();
    if (isClosed) return;

    emit(const ProfileDeleted());
  }

  Future<void> logout() async {
    final current = state;
    final currentProfile = current.profile;
    if (current is ProfileLoaded && current.isLoggingOut) return;

    if (currentProfile != null) {
      emit(ProfileLoaded(profile: currentProfile, isLoggingOut: true));
    }

    await logoutUseCase();
    await sessionCleanupService.clearSession();
    if (isClosed) return;

    emit(const ProfileLoggedOut());
  }
}
