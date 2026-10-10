import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/load_more_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_refresh_indicator.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/subscriptions/presentation/mapper/subscription_mapper.dart';
import '../controllers/subscriptions_cubit/subscriptions_cubit.dart';
import '../controllers/subscriptions_cubit/subscriptions_state.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
      listener: (context, state) {
        if (state is SubscriptionsErrorState) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        final subscriptions = state.subscriptions?.subscriptions ?? [];

        final isLoadingInitial =
            state is SubscriptionsInitialState ||
            state is SubscriptionsLoadingState;

        final initialError =
            state is SubscriptionsErrorState && subscriptions.isEmpty;

        final loadMoreError =
            state is SubscriptionsErrorState && subscriptions.isNotEmpty;

        final isEmpty =
            state is SubscriptionsLoadedState && subscriptions.isEmpty;

        final isLoadingMore =
            state is SubscriptionsLoadedState && state.isLoadingMore;

        if (isLoadingInitial) {
          return ShimmerList(itemBuilder: (_, _) => SubscriberCardShimmer());
        }

        if (initialError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () =>
                context.read<SubscriptionsCubit>().fetchUserSubscriptions(),
            iconSize: 56.r,
            retryIcon: Icons.refresh,
          );
        }

        if (isEmpty) {
          return const AppEmptyWidget(
            message: 'There are no subscription till now',
          );
        }

        return AppRefreshIndicator(
          onRefresh: () =>
              context.read<SubscriptionsCubit>().fetchUserSubscriptions(),
          child: LoadMoreListener(
            onLoadMore: () {
              if (state is SubscriptionsLoadedState) {
                context.read<SubscriptionsCubit>().loadMore();
              }
            },
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount:
                  subscriptions.length +
                  (isLoadingMore || loadMoreError ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == subscriptions.length) {
                  if (isLoadingMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  if (loadMoreError) {
                    return LoadMoreErrorWidget(message: state.message);
                  }
                  return const SizedBox.shrink();
                }

                final subscription = subscriptions[index];
                return SubscriberCardWidget(
                  subscriber: subscription.toSubscriberCardData(),
                  onTap: () => context.navigateTo(
                    AppRoutes.channelDetails,
                    arguments: subscription.channel.id,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
