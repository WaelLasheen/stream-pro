import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_data.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/feature/library/presentation/widgets/library_see_all_tile.dart';

class LibraryRail extends StatelessWidget {
  final List<VideoCardData> videos;
  final ValueChanged<VideoCardData> onVideoTap;
  final VoidCallback onSeeAll;

  const LibraryRail({
    super.key,
    required this.videos,
    required this.onVideoTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.libraryRailHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: videos.length + 1,
        separatorBuilder: (_, __) => 12.horizontalSpace,
        itemBuilder: (context, index) {
          if (index == videos.length) {
            return LibrarySeeAllTile(onTap: onSeeAll);
          }
          final video = videos[index];
          return VideoCardWidget.compact(
            video: video,
            onTap: () => onVideoTap(video),
          );
        },
      ),
    );
  }
}
