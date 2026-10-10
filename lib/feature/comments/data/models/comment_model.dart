import '../../domain/entities/comment_entity.dart';

class CommentModel {
  final String commentId;
  final String videoId;
  final String content;
  final bool isEdited;
  final String userId;
  final String userName;
  final String userProfileImage;
  final int replyCount;
  final DateTime createdAt;

  const CommentModel({
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

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      content: json['content'],
      videoId: json['videoId'],
      isEdited: json['isEditted'] ?? false,
      userId: json['userId'],
      userName: json['userName'] ?? '',
      userProfileImage: json['userProfileImage'] ?? '',
      replyCount: json['replyCount'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      content: content,
      videoId: videoId,
      isEdited: isEdited,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      replyCount: replyCount,
      createdAt: createdAt,
    );
  }
}
