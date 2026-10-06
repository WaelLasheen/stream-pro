import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/managed_video_entity.dart';
import '../../domain/params/init_video_params.dart';
import '../../domain/params/update_video_params.dart';

class VideoInfoFormController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsInputController = TextEditingController();

  final ValueNotifier<String?> categoryId = ValueNotifier<String?>(null);
  final ValueNotifier<List<String>> tags = ValueNotifier<List<String>>(
    const [],
  );

  // Edit Screen Pending Changes
  final ValueNotifier<String?> pendingThumbnailPath = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<bool?> pendingIsPublished = ValueNotifier<bool?>(null);

  // Upload Screen File Selections
  final ValueNotifier<PlatformFile?> selectedVideoFile =
      ValueNotifier<PlatformFile?>(null);
  final ValueNotifier<PlatformFile?> selectedThumbnailFile =
      ValueNotifier<PlatformFile?>(null);

  /// Pre-fill from an existing video (edit flow).
  void fill(ManagedVideoEntity video) {
    titleController.text = video.title;
    descriptionController.text = video.description;
    categoryId.value = video.categoryId;
    pendingIsPublished.value = video.isPublished;
    tags.value = List<String>.of(video.tags);
    tagsInputController.clear();
    pendingThumbnailPath.value = null;
  }

  /// Upload flow.
  InitVideoParams toInitParams() {
    return InitVideoParams(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      categoryId: categoryId.value!,
      tags: tags.value,
    );
  }

  /// Edit flow.
  UpdateVideoParams toUpdateParams() {
    return UpdateVideoParams(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      categoryId: categoryId.value,
      tags: tags.value,
    );
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryId.dispose();
    tags.dispose();
    tagsInputController.dispose();
    pendingThumbnailPath.dispose();
    pendingIsPublished.dispose();
    selectedThumbnailFile.dispose();
    selectedVideoFile.dispose();
  }
}
