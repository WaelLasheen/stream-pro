import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/file_pick_tile.dart';

class FilePickerSection extends StatelessWidget {
  final String title;
  final ValueNotifier<PlatformFile?> fileNotifier;
  final bool isImage;
  final IconData icon;
  final String emptyTitle;
  final String emptySubtitle;
  final bool enabled;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const FilePickerSection({
    super.key,
    required this.title,
    required this.fileNotifier,
    required this.isImage,
    required this.icon,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.enabled,
    required this.onPick,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        8.verticalSpace,
        ValueListenableBuilder<PlatformFile?>(
          valueListenable: fileNotifier,
          builder: (context, file, _) {
            return FilePickTile(
              file: file,
              isImage: isImage,
              icon: icon,
              emptyTitle: emptyTitle,
              emptySubtitle: emptySubtitle,
              enabled: enabled,
              onPick: onPick,
              onClear: onClear,
            );
          },
        ),
      ],
    );
  }
}
