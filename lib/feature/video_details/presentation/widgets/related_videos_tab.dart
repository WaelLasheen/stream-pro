import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/related_videos_cubit/related_videos_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/mapper/related_video_mapper.dart';
import 'package:stream_pro/generated/l10n.dart';

class RelatedVideosTab extends StatelessWidget {
  final String videoId;
  final SliverOverlapAbsorberHandle handle;

  const RelatedVideosTab({
    super.key,
    required this.videoId,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatedVideosCubit, RelatedVideosState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: handle),
            switch (state) {
              RelatedVideosInitial() ||
              RelatedVideosLoading() => SliverShimmerList(
                itemBuilder: (_, __) => const VideoCardShimmer(),
                itemCount: 5,
              ),
              RelatedVideosFailure() => AppErrorSliver(
                message: state.message,
                onRetry: () => context
                    .read<RelatedVideosCubit>()
                    .fetchRelatedVideos(videoId),
              ),
              RelatedVideosLoaded() =>
                state.videos.isEmpty
                    ? AppEmptySliver(message: S.current.noRelatedVideosFound)
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final video = state.videos[index];
                            return VideoCardWidget(
                              video: video.toVideoCardData(),
                              onTap: () {
                                context.navigateTo(
                                  AppRoutes.videoDetails,
                                  arguments: VideoDetailsArgs(video.videoId),
                                );
                              },
                            );
                          }, childCount: state.videos.length),
                        ),
                      ),
            },
          ],
        );
      },
    );
  }
}
