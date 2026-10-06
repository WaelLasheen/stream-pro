import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/channel/common_slivers.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/subscribers_cubit/subscribers_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/subscribers_cubit/subscribers_state.dart';
import 'package:stream_pro/feature/owner_channel/presentation/mappers/subscriber_mapper.dart';

class SubscribersTab extends StatelessWidget {
  final SliverOverlapAbsorberHandle handle;

  const SubscribersTab({super.key, required this.handle});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribersCubit, SubscribersState>(
      listener: (context, state) {
        if (state is SubscribersErrorState) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        final items = state.subscribers?.items ?? [];

        final isLoadingInitial =
            state is SubscribersInitialState ||
            state is SubscribersLoadingState;

        final initialError = state is SubscribersErrorState && items.isEmpty;
        final loadMoreError =
            state is SubscribersErrorState && items.isNotEmpty;

        final errorMessage = state is SubscribersErrorState
            ? state.message
            : null;
        final isLoadingMore =
            state is SubscribersLoadedState && state.isLoadingMore;

        return LoadMoreListener(
          onLoadMore: () {
            if (state is SubscribersLoadedState) {
              context.read<SubscribersCubit>().loadMore();
            }
          },
          child: CustomScrollView(
            key: const PageStorageKey('subscribers'),
            slivers: [
              SliverOverlapInjector(handle: handle),

              if (isLoadingInitial)
                SliverShimmerList(
                  itemBuilder: (_, _) => const SubscriberCardShimmer(),
                )
              else if (initialError)
                AppErrorSliver(
                  message: errorMessage ?? 'Failed to load subscribers',
                  onRetry: () =>
                      context.read<SubscribersCubit>().fetchSubscribers(),
                  iconSize: 42.r,
                )
              else ...[
                if (items.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.all(16.r),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final subscriber = items[index];
                        return SubscriberCardWidget(
                          subscriber: subscriber.toSubscriberCardData(),
                          onTap: () {},
                        );
                      }, childCount: items.length),
                    ),
                  )
                else if (state is SubscribersLoadedState)
                  const AppEmptySliver(message: 'No subscribers yet'),

                // Footer Slivers (cleanly separated from the main list)
                if (isLoadingMore)
                  const SliverLoadMoreLoader()
                else if (loadMoreError)
                  SliverLoadMoreError(
                    message: errorMessage ?? 'Failed to load more subscribers',
                    onRetry: () => context.read<SubscribersCubit>().loadMore(),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
