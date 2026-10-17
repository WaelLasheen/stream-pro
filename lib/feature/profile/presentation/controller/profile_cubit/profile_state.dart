import 'package:equatable/equatable.dart';
import '../../../domain/entities/profile_entity.dart';

sealed class ProfileState extends Equatable {
  final ProfileEntity? profile;
  const ProfileState({this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final bool isSaving;
  final bool isDeleting;

  const ProfileLoaded({
    required ProfileEntity super.profile,
    this.isSaving = false,
    this.isDeleting = false,
  });

  ProfileLoaded copyWith({
    ProfileEntity? profile,
    bool? isSaving,
    bool? isDeleting,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile!,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [profile, isSaving, isDeleting];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message, super.profile});

  @override
  List<Object?> get props => [message, profile];
}

class ProfileDeleted extends ProfileState {
  const ProfileDeleted();
}
