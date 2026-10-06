import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/feature/owner_channel/presentation/args/channel_editor_args.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/owner_channel_header.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/owner_channel_tab_bar.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/owner_playlists_tab.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/owner_videos_tab.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/subscribers_tab.dart';

class OwnerChannelView extends StatelessWidget {
  final OwnerChannelEntity channel;

  const OwnerChannelView({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 300.h,
                toolbarHeight: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: OwnerChannelHeader(
                    channel: channel,
                    onEditTap: () {
                      context.navigateTo(
                        AppRoutes.channelEditor,
                        arguments: ChannelEditorArgs(
                          cubit: context.read<OwnerChannelCubit>(),
                          channel: channel,
                        ),
                      );
                    },
                  ),
                ),
                bottom: const OwnerChannelTabBar(),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            final handle = NestedScrollView.sliverOverlapAbsorberHandleFor(
              context,
            );

            return TabBarView(
              children: [
                OwnerVideosTab(handle: handle),
                OwnerPlaylistsTab(handle: handle),
                SubscribersTab(handle: handle),
              ],
            );
          },
        ),
      ),
    );
  }
}
