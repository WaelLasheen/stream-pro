import 'package:equatable/equatable.dart';

sealed class DownloadState extends Equatable {
  const DownloadState();
  @override
  List<Object?> get props => [];
}

class DownloadInitial extends DownloadState {}

class DownloadInProgress extends DownloadState {
  final double progress; // 0.0 to 1.0, or -1 for indeterminate
  const DownloadInProgress(this.progress);
  @override
  List<Object?> get props => [progress];
}

class DownloadSuccess extends DownloadState {
  const DownloadSuccess();
}

class DownloadError extends DownloadState {
  final String message;
  const DownloadError(this.message);
  @override
  List<Object?> get props => [message];
}
