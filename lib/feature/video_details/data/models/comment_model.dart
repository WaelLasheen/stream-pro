import 'package:stream_pro/feature/video_details/domain/entities/comment_entity.dart';

class CommentModel {
  final String commentId;
  final String content;
  final bool isEditted;
  final String userId;
  final String userName;
  final String userProfileImage;
  final String createdAt;

  CommentModel({
    required this.commentId,
    required this.content,
    required this.isEditted,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] ?? '',
      content: json['content'] ?? '',
      isEditted: json['isEditted'] ?? false,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userProfileImage: json['userProfileImage'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      content: content,
      isEditted: isEditted,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    );
  }
}