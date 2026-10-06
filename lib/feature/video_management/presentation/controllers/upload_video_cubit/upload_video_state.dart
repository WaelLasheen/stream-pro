abstract class UploadVideoState {}

class UploadVideoInitial extends UploadVideoState {}

class UploadVideoLoading extends UploadVideoState {}

class UploadVideoSuccess extends UploadVideoState {}

class UploadVideoError extends UploadVideoState {
  final String message;
  UploadVideoError(this.message);
}
