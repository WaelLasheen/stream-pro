import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String commentId;
  final String content;
  final bool isEditted;
  final String userId;
  final String userName;
  final String userProfileImage;
  final DateTime createdAt;

  const CommentEntity({
    required this.commentId,
    required this.content,
    required this.isEditted,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    commentId,
    content,
    isEditted,
    userId,
    userName,
    userProfileImage,
    createdAt,
  ];
}
