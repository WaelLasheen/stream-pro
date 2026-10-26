import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_widget.dart';
import 'package:stream_pro/core/shared/widgets/load_more_listener.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/shimmer_list.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_cubit.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_state.dart';
import 'package:stream_pro/feature/search/presentation/widgets/category_filter_bar.dart';
import 'package:stream_pro/feature/search/presentation/widgets/category_shimmer.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_cubit/search_cubit.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_cubit/search_state.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_suggestions_cubit/search_suggestions_cubit.dart';
import 'package:stream_pro/feature/search/presentation/mapper/search_video_mapper.dart';
import 'package:stream_pro/feature/search/presentation/widgets/search_suggestions_view.dart';
import 'package:stream_pro/feature/video_details/presentation/args/video_details_args.dart';

class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({super.key});

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen> {
  final _searchController = TextEditingController();
  final _selectedCategoryNotifier = ValueNotifier<String?>(null);
  final _showSuggestionsNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _selectedCategoryNotifier.addListener(() {
      _onCategoryChanged();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _selectedCategoryNotifier.dispose();
    _showSuggestionsNotifier.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    final canSuggest =
        query.trim().length >= SearchSuggestionsCubit.minQueryLength;
    _showSuggestionsNotifier.value = canSuggest;
    context.read<SearchSuggestionsCubit>().onQueryChanged(query);
    if (!canSuggest) context.read<SearchCubit>().clearSearch();
  }

  void _onSubmitted(String query) {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    _showSuggestionsNotifier.value = false;
    context.read<SearchCubit>().search(
      query: query,
      category: _selectedCategoryNotifier.value,
    );
  }

  void _onCategoryChanged() {
    final query = _searchController.text;
    if (query.trim().isEmpty) return;
    _showSuggestionsNotifier.value = false;
    context.read<SearchCubit>().search(
      query: query,
      category: _selectedCategoryNotifier.value,
    );
  }

  void _openVideo(String videoId) {
    FocusScope.of(context).unfocus();
    context.navigateTo(
      AppRoutes.videoDetails,
      arguments: VideoDetailsArgs(videoId),
    );
  }

  void _loadMore() {
    context.read<SearchCubit>().loadMore(
      query: _searchController.text,
      category: _selectedCategoryNotifier.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: AppFormField(
                controller: _searchController,
                hint: 'Search videos...',
                prefixIcon: Icons.search,
                onChanged: _onQueryChanged,
                onFieldSubmitted: _onSubmitted,
                textInputAction: TextInputAction.search,
              ),
            ),

            // 2. Category Filter Bar (with Shimmer support)
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading || state is CategoryInitial) {
                  return const CategoryFilterBarShimmer();
                }

                if (state is CategoryLoaded) {
                  return ValueListenableBuilder<String?>(
                    valueListenable: _selectedCategoryNotifier,
                    builder: (context, _, __) {
                      return CategoryFilterBar(
                        categories: state.categories,
                        selectedCategoryNotifier: _selectedCategoryNotifier,
                      );
                    },
                  );
                }
                return 40.verticalSpace;
              },
            ),

            12.verticalSpace,

            // Search Results
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _showSuggestionsNotifier,
                builder: (context, showSuggestions, _) {
                  if (showSuggestions) {
                    return SearchSuggestionsView(
                      onSuggestionTap: _openVideo,
                      onRetry: () =>
                          context.read<SearchSuggestionsCubit>().retry(),
                    );
                  }
                  return BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return AppEmptyWidget(
                          message: 'Type to search videos...',
                          icon: Icons.play_circle_outline_rounded,
                        );
                      }

                      if (state is SearchLoading) {
                        return ShimmerList(
                          itemBuilder: (_, _) => VideoCardShimmer(),
                        );
                      }

                      if (state is SearchFailure &&
                          state.searchResult == null) {
                        return AppErrorWidget(
                          message: state.message,
                          onRetry: () => _onSubmitted(_searchController.text),
                        );
                      }

                      if (state.searchResult != null) {
                        final items = state.searchResult?.items ?? [];

                        if (items.isEmpty) {
                          return AppEmptyWidget(
                            message:
                                'No videos found for "${_searchController.text}"',
                            icon: Icons.search_off_rounded,
                          );
                        }

                        return LoadMoreListener(
                          onLoadMore: () {
                            if (state is SearchLoaded) {
                              _loadMore();
                            }
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: items.length + 1,
                            key: const PageStorageKey('search_videos'),
                            itemBuilder: (context, index) {
                              if (index == items.length) {
                                if (state is SearchFailure) {
                                  return AppErrorWidget(
                                    message: state.message,
                                    onRetry: () => _loadMore(),
                                  );
                                }
                                if (state is SearchLoaded &&
                                    state.isLoadingMore) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    child: const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              }

                              final video = items[index];
                              return VideoCardWidget(
                                video: video.toVideoCardData(),
                                onTap: () {
                                  context.navigateTo(
                                    AppRoutes.videoDetails,
                                    arguments: VideoDetailsArgs(video.videoId),
                                  );
                                },
                                onChannelTap: () {
                                  context.navigateTo(
                                    AppRoutes.channelDetails,
                                    arguments: video.channelId,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
