import 'package:equatable/equatable.dart';

class UpdateVideoParams extends Equatable {
  final String? title;
  final String? description;
  final String? categoryId;
  final List<String>? tags;
  final DateTime? publishTime;

  const UpdateVideoParams({
    this.title,
    this.description,
    this.categoryId,
    this.tags,
    this.publishTime,
  });

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (categoryId != null) 'categoryId': categoryId,
      if (tags != null) 'tags': tags,
      if (publishTime != null)
        'publishTime': publishTime!.toUtc().toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    title,
    description,
    categoryId,
    tags,
    publishTime,
  ];
}
