class PlaylistDetailsArgs {
  final String playlistId;
  final bool isOwner;

  const PlaylistDetailsArgs(this.playlistId, {this.isOwner = false});
}
