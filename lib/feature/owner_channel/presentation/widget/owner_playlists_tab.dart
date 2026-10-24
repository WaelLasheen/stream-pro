import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_sliver.dart';
import 'package:stream_pro/core/shared/widgets/empty_view/app_empty_sliver.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_data.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_shimmer.dart';
import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_widget.dart';
import 'package:stream_pro/core/shared/widgets/shimmer_list/sliver_shimmer_list.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_state.dart';
import 'package:stream_pro/feature/owner_channel/presentation/mappers/owner_playlist_mapper.dart';
import 'package:stream_pro/feature/playlist/presentation/args/playlist_details_args.dart';

class OwnerPlaylistsTab extends StatelessWidget {
  final SliverOverlapAbsorberHandle handle;

  const OwnerPlaylistsTab({super.key, required this.handle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerPlaylistsCubit, OwnerPlaylistsState>(
      builder: (context, state) {
        return CustomScrollView(
          key: const PageStorageKey('owner_playlists'),
          slivers: [
            SliverOverlapInjector(handle: handle),

            if (state is OwnerPlaylistsInitialState ||
                state is OwnerPlaylistsLoadingState)
              SliverShimmerList(
                itemBuilder: (_, _) => const PlaylistCardShimmer(
                  variant: PlaylistCardVariant.horizontal,
                ),
              )
            else if (state is OwnerPlaylistsErrorState)
              AppErrorSliver(
                message: state.message,
                onRetry: () =>
                    context.read<OwnerPlaylistsCubit>().fetchOwnerPlaylists(),
                iconSize: 42.r,
              )
            else if (state is OwnerPlaylistsLoadedState)
              if (state.playlists.isEmpty)
                const AppEmptySliver(message: 'No playlists yet')
              else
                SliverPadding(
                  padding: EdgeInsets.all(12.r),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final playlist = state.playlists[index];

                      return PlaylistCardWidget(
                        playlist: playlist.toVideoCardData(),
                        variant: PlaylistCardVariant.horizontal,
                        onTap: () => context.navigateTo(
                          AppRoutes.playlistDetails,
                          arguments: PlaylistDetailsArgs(
                            playlist.id,
                            isOwner: true,
                          ),
                        ),
                      );
                    }, childCount: state.playlists.length),
                  ),
                ),
          ],
        );
      },
    );
  }
}
