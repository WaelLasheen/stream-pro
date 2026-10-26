import 'package:equatable/equatable.dart';

class WatchLaterButtonState extends Equatable {
  final bool isInWatchLater;
  final bool isLoadingStatus;
  final bool isUpdating;

  const WatchLaterButtonState({
    this.isInWatchLater = false,
    this.isLoadingStatus = true,
    this.isUpdating = false,
  });

  bool get isBusy => isLoadingStatus || isUpdating;

  WatchLaterButtonState copyWith({
    bool? isInWatchLater,
    bool? isLoadingStatus,
    bool? isUpdating,
  }) {
    return WatchLaterButtonState(
      isInWatchLater: isInWatchLater ?? this.isInWatchLater,
      isLoadingStatus: isLoadingStatus ?? this.isLoadingStatus,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props => [isInWatchLater, isLoadingStatus, isUpdating];
}
