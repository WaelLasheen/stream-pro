import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/entity/category_entity.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'tags_input.dart';
import 'video_info_form_controller.dart';

class VideoInfoForm extends StatelessWidget {
  final VideoInfoFormController controller;
  final List<CategoryEntity> categories;
  final bool enabled;

  const VideoInfoForm({
    super.key,
    required this.controller,
    required this.categories,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormField(
          controller: controller.titleController,
          label: 'Video Title *',
          hint: 'Enter a catchy title',
          prefixIcon: Icons.title,
          enabled: enabled,
          textInputAction: TextInputAction.next,
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Title is required'
              : null,
        ),
        SizedBox(height: 16.h),
        AppFormField(
          controller: controller.descriptionController,
          label: 'Description *',
          hint: 'What is this video about?',
          prefixIcon: Icons.description,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          minLines: 3,
          enabled: enabled,
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Description is required'
              : null,
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<String?>(
          valueListenable: controller.categoryId,
          builder: (context, selected, _) {
            final safeValue = categories.any((c) => c.id == selected)
                ? selected
                : null;
            return DropdownButtonFormField<String>(
              value: safeValue,
              key: ValueKey(safeValue),
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Category *',
                prefixIcon: const Icon(Icons.category_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                ),
              ),
              items: [
                for (final category in categories)
                  DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
              ],
              onChanged: enabled
                  ? (value) => controller.categoryId.value = value
                  : null,
              validator: (value) =>
                  value == null ? 'Category is required' : null,
            );
          },
        ),
        SizedBox(height: 16.h),

        TagsInput(
          inputController: controller.tagsInputController,
          tagsNotifier: controller.tags,
          enabled: enabled,
        ),
      ],
    );
  }
}
