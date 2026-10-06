class InitVideoParams {
  final String title;
  final String description;
  final String categoryId;
  final List<String>? tags;
  final DateTime? publishTime;

  const InitVideoParams({
    required this.title,
    required this.description,
    required this.categoryId,
    this.tags,
    this.publishTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categoryId': categoryId,
      if (tags != null && tags!.isNotEmpty) 'tags': tags,
      if (publishTime != null) 'publishTime': publishTime!.toUtc().toIso8601String(),
    };
  }
}
