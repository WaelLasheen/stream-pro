import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int videoCount;
  final int totalViews;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.videoCount,
    required this.totalViews,
  });

  ProfileEntity copyWith({
    String? name,
    String? avatarUrl,
    bool clearAvatar = false,
  }) {
    return ProfileEntity(
      id: id,
      name: name ?? this.name,
      email: email,
      avatarUrl: clearAvatar ? null : (avatarUrl ?? this.avatarUrl),
      createdAt: createdAt,
      updatedAt: updatedAt,
      videoCount: videoCount,
      totalViews: totalViews,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    avatarUrl,
    createdAt,
    updatedAt,
    videoCount,
    totalViews,
  ];
}
