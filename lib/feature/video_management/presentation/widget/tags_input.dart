import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_form_field.dart';

class TagsInput extends StatelessWidget {
  final TextEditingController inputController;
  final ValueNotifier<List<String>> tagsNotifier;
  final bool enabled;

  const TagsInput({
    super.key,
    required this.inputController,
    required this.tagsNotifier,
    this.enabled = true,
  });

  void _add(String raw) {
    final tag = raw.replaceAll(',', '').trim();
    if (tag.isEmpty) return;

    final exists = tagsNotifier.value.any(
      (t) => t.toLowerCase() == tag.toLowerCase(),
    );

    if (!exists) {
      tagsNotifier.value = [...tagsNotifier.value, tag];
    }

    inputController.clear();
  }

  void _remove(String tag) {
    tagsNotifier.value = tagsNotifier.value.where((t) => t != tag).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormField(
          controller: inputController,
          label: 'Tags',
          hint: 'Add a tag and press done',
          prefixIcon: Icons.sell_outlined,
          enabled: enabled,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: _add,
          onChanged: (value) {
            if (value.endsWith(',')) _add(value);
          },
        ),
        ValueListenableBuilder<List<String>>(
          valueListenable: tagsNotifier,
          builder: (context, tags, _) {
            if (tags.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                children: [
                  for (final tag in tags)
                    InputChip(
                      label: Text(tag),
                      onDeleted: enabled ? () => _remove(tag) : null,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
