import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/home/presentation/widgets/video_list_view.dart';
import '../controller/home_cubit/home_cubit.dart';
import '../controller/home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        switch (state) {
          case HomeInitialState():
          case HomeLoadingState():
            return ShimmerList(itemBuilder: (_, _) => VideoCardShimmer());

          case HomeLoadedState():
            if (state.videos.isEmpty) {
              return const AppEmptyWidget(
                message: 'No feeds available at the moment.',
              );
            }
            return VideoListView(
              videos: state.videos,
              isLoadingMore: state.isLoadingMore,
              onRefresh: () => context.read<HomeCubit>().fetchFeed(),
              onLoadMore: () => context.read<HomeCubit>().loadMore(),
            );

          case HomeErrorState():
            if (state.videos.isEmpty) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<HomeCubit>().fetchFeed(),
                iconSize: 56.r,
                retryIcon: Icons.refresh,
              );
            }
            return VideoListView(
              videos: state.videos,
              onRefresh: () => context.read<HomeCubit>().fetchFeed(),
            );
        }
      },
    );
  }
}
