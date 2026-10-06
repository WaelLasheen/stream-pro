import 'package:equatable/equatable.dart';

sealed class LikesState extends Equatable {
  final bool isLiked;
  final int likesCount;

  const LikesState({required this.isLiked, required this.likesCount});

  @override
  List<Object?> get props => [isLiked, likesCount];
}

final class LikesInitial extends LikesState {
  const LikesInitial({required super.isLiked, required super.likesCount});
}

final class LikesUpdated extends LikesState {
  const LikesUpdated({required super.isLiked, required super.likesCount});
}

final class LikesFailure extends LikesState {
  final String errorMessage;

  const LikesFailure({
    required super.isLiked,
    required super.likesCount,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [isLiked, likesCount, errorMessage];
}
