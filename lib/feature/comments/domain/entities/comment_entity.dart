import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String commentId;
  final String content;
  final String videoId;
  final bool isEdited;
  final String userId;
  final String userName;
  final String userProfileImage;
  final int replyCount;
  final DateTime createdAt;

  const CommentEntity({
    required this.commentId,
    required this.content,
    required this.videoId,
    required this.isEdited,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.replyCount,
    required this.createdAt,
  });

  factory CommentEntity.temp({
    required String content,
    required String videoId,
    required String userId,
    required String userName,
    required String userProfileImage,
  }) {
    return CommentEntity(
      commentId: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      videoId: videoId,
      isEdited: false,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      replyCount: 0,
      createdAt: DateTime.now(),
    );
  }

  CommentEntity copyWith({
    String? commentId,
    String? content,
    bool? isEdited,
    int? replyCount,
  }) {
    return CommentEntity(
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      videoId: videoId,
      isEdited: isEdited ?? this.isEdited,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      replyCount: replyCount ?? this.replyCount,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
    commentId,
    content,
    videoId,
    isEdited,
    userId,
    userName,
    userProfileImage,
    replyCount,
    createdAt,
  ];
}
