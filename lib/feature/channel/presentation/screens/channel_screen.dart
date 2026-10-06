import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_state.dart';
import 'package:stream_pro/feature/channel/presentation/widget/channel_header.dart';
import 'package:stream_pro/feature/channel/presentation/widget/channel_home_tab.dart';
import 'package:stream_pro/feature/channel/presentation/widget/channel_playlists_tab.dart';
import 'package:stream_pro/feature/channel/presentation/widget/channel_videos_tab.dart';
import 'package:stream_pro/feature/channel/presentation/widget/channel_tab_bar.dart';

class ChannelScreen extends StatelessWidget {
  final String channelId;

  const ChannelScreen({super.key, required this.channelId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<ChannelDetailsCubit, ChannelDetailsState>(
        builder: (context, state) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      expandedHeight: 300.h,
                      toolbarHeight: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: ChannelHeader(
                          state: state,
                          channelId: channelId,
                        ),
                      ),
                      bottom: const ChannelTabBar(),
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (context) {
                  final handle =
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context);

                  return TabBarView(
                    children: [
                      ChannelHomeTab(channelId: channelId, handle: handle),
                      ChannelVideosTab(channelId: channelId, handle: handle),
                      ChannelPlaylistsTab(channelId: channelId, handle: handle),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
