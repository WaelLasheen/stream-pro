import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import '../controller/home_cubit/home_cubit.dart';
import '../controller/home_cubit/home_state.dart';
import '../widgets/feed_section_widget.dart';
import '../widgets/home_feed_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _selectedFilterIndex = ValueNotifier<int>(0);
  final List<String> _filters = const ['All', 'Trending', 'Live', 'Podcasts', 'Music'];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchFeed();
  }

  @override
  void dispose() {
    _selectedFilterIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.play_circle_fill_rounded,
              color: theme.colorScheme.primary,
              size: 32.r,
            ),
            8.horizontalSpace,
            Text(
              'StreamPro',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, size: 24.r),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, size: 24.r),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips using ValueNotifier
          SizedBox(
            height: 52.h,
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedFilterIndex,
              builder: (context, selectedIndex, _) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: ChoiceChip(
                        label: Text(
                          _filters[index],
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) => _selectedFilterIndex.value = index,
                        selectedColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 0.5),

          // Main Feed List
          Expanded(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeErrorState) {
                  context.showErrorSnackBar(message: state.message);
                }
              },
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const HomeFeedShimmer();
                }

                if (state is HomeErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 56.r,
                          color: theme.colorScheme.error,
                        ),
                        12.verticalSpace,
                        Text(
                          state.message,
                          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
                        ),
                        16.verticalSpace,
                        ElevatedButton.icon(
                          onPressed: () => context.read<HomeCubit>().fetchFeed(),
                          icon: const Icon(Icons.refresh),
                          label: Text('Retry', style: TextStyle(fontSize: 14.sp)),
                        ),
                      ],
                    ),
                  );
                }

                if (state is HomeLoadedState) {
                  if (state.sections.isEmpty) {
                    return Center(
                      child: Text(
                        'No feeds available at the moment.',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<HomeCubit>().fetchFeed(),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                      itemCount: state.sections.length,
                      itemBuilder: (context, index) {
                        return FeedSectionWidget(section: state.sections[index]);
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}