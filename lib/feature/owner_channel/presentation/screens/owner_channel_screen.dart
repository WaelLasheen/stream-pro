import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/shared/widgets/channel/channel_header_shimmer.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/owner_channel/presentation/args/channel_editor_args.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_state.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/owner_channel_view.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/no_owner_channel_widget.dart';

class OwnerChannelScreen extends StatelessWidget {
  const OwnerChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OwnerChannelCubit, OwnerChannelState>(
        builder: (context, state) {
          if (state is OwnerChannelLoadingState) {
            return const ChannelHeaderShimmer();
          }

          if (state is OwnerChannelNoChannelState) {
            return NoOwnerChannelWidget(
              onCreatePressed: () {
                context.navigateTo(
                  AppRoutes.channelEditor,
                  arguments: ChannelEditorArgs(
                    cubit: context.read<OwnerChannelCubit>(),
                  ),
                );
              },
            );
          }

          if (state is OwnerChannelErrorState && state.channel == null) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<OwnerChannelCubit>().fetchOwnerChannel(),
              icon: Icons.wifi_off_rounded,
            );
          }

          if (state.channel != null) {
            return OwnerChannelView(channel: state.channel!);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
