import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import '../../domain/entities/feed_section_entity.dart';
import 'section_header.dart';
import 'video_card.dart';

class FeedSectionWidget extends StatelessWidget {
  final FeedSectionEntity section;

  const FeedSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    if (section.videos.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: section.title,
          type: section.type,
          onSeeAllTap: () {},
        ),
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: section.videos.length,
            itemBuilder: (context, index) {
              final video = section.videos[index];
              return VideoCard(
                video: video,
                onTap: () {
                  context.navigateTo(
                    AppRoutes.videoDetails,
                    arguments: video.id,
                  );
                },
              );
            },
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
