import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/feature/home/presentation/widgets/video_list_view.dart';
import 'package:stream_pro/generated/l10n.dart';
import '../controller/home_cubit/home_cubit.dart';
import '../controller/home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final videos = state.videos;
        final isLoadingInitial =
            state is HomeInitialState || state is HomeLoadingState;
        final initialError = state is HomeErrorState && videos.isEmpty;
        final loadMoreError = state is HomeErrorState && videos.isNotEmpty;
        final errorMessage = state is HomeErrorState ? state.message : null;
        final isLoadingMore = state is HomeLoadedState && state.isLoadingMore;

        if (isLoadingInitial) {
          return ShimmerList(itemBuilder: (_, _) => const VideoCardShimmer());
        }

        if (initialError) {
          return AppErrorWidget(
            message: errorMessage ?? S.current.somethingWentWrong,
            onRetry: () => context.read<HomeCubit>().fetchFeed(),
            iconSize: 56.r,
            retryIcon: Icons.refresh,
          );
        }

        if (state is HomeLoadedState && videos.isEmpty) {
          return AppEmptyWidget(message: S.current.noFeedsAvailableAtTheMoment);
        }

        return VideoListView(
          videos: videos,
          isLoadingMore: isLoadingMore,
          loadMoreError: loadMoreError ? errorMessage : null,
          onRefresh: () => context.read<HomeCubit>().fetchFeed(),
          onLoadMore: state is HomeLoadedState
              ? () => context.read<HomeCubit>().loadMore()
              : null,
          onRetry: () => context.read<HomeCubit>().loadMore(),
        );
      },
    );
  }
}
