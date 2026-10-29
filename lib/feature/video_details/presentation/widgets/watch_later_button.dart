import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/widgets/action_button.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_button_cubit/watch_later_button_cubit.dart';
import 'package:stream_pro/feature/watch_later/presentation/controllers/watch_later_button_cubit/watch_later_button_state.dart';
import 'package:stream_pro/generated/l10n.dart';

class WatchLaterButton extends StatelessWidget {
  final String videoId;

  const WatchLaterButton({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WatchLaterButtonCubit>()..loadStatus(videoId),
      child: BlocBuilder<WatchLaterButtonCubit, WatchLaterButtonState>(
        builder: (context, state) {
          return ActionButton(
            icon: state.isBusy
                ? Icons.hourglass_top_rounded
                : state.isInWatchLater
                ? Icons.watch_later
                : Icons.watch_later_outlined,
            label: state.isInWatchLater
                ? S.current.added
                : S.current.watchLater,
            onTap: () async {
              if (state.isBusy) return;

              final result = await context.read<WatchLaterButtonCubit>().toggle(
                videoId,
              );
              if (result == null || !context.mounted) return;

              result.fold(
                (failure) =>
                    context.showErrorSnackBar(message: failure.message),
                (isInWatchLater) => context.showSuccessSnackBar(
                  message: isInWatchLater
                      ? S.current.addedToWatchLater
                      : S.current.removedFromWatchLater,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
