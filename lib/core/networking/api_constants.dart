class ApiConstants {
  static const String baseURL = "https://stream-pro-ten.vercel.app/api/v1/";

  // Auth
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String refresh = "auth/refresh";
  static const String logout = "auth/logout";

  // Home
  static const String feed = "feed";

  // Video Details & Interactions
  static String videoDetails(String videoId) => "videos/$videoId";
  static String videoViews(String videoId) => "videos/$videoId/views";
  static String relatedVideos(String videoId) => "videos/$videoId/related";
  static String downloadVideo(String videoId) => 'downloads/$videoId';

  // Like & Liked video
  static String likedVideos = "likes";
  static String likeVideo(String videoId) => "likes/$videoId";

  // comments
  static String comments = "comments";
  static String videoComments(String videoId) => "comments/$videoId";
  static String editComment(String commentId) => "comments/$commentId";
  static String commentReplies(String commentId) =>
      "comments/$commentId/replies";

  // Owner Channels
  static const String ownerChannels = "owner/channels";
  static const String uploadChannelAvatar =
      "owner/channels/upload-channel-image";
  static const String uploadChannelThumbnail =
      "owner/channels/upload-thumbnail";

  // Public Channel Endpoints
  static String channelDetails(String channelId) => "channels/$channelId";
  static String channelHome(String channelId) => "channels/$channelId/home";
  static String channelVideos(String channelId) => "channels/$channelId/videos";
  static String channelPlaylists(String channelId) =>
      "channels/$channelId/playlists";

  // Subscriptions
  static String subscription(String channelId) => "subscriptions/$channelId";
  static const String subscribers = "owner/subscriptions";
  static const String subscriptions = "subscriptions";

  // Video Management
  static const String ownerVideos = "owner/videos";
  static String ownerVideoById(String id) => 'owner/videos/$id';
  static const String initiateVideoUpload = "owner/videos/initiate";
  static String completeVideoUpload(String videoId) =>
      "owner/videos/$videoId/video-upload-completed";
  static String completeThumbnailUpload(String videoId) =>
      "owner/videos/$videoId/thumbnail-upload-completed";
  static String changeVideoPublishStatus(String id) =>
      'owner/videos/$id/change-publish-status';
  static String videoThumbnailSignature(String id) =>
      'owner/videos/$id/thumbnail/signature';

  // Watch History
  static const String watchHistory = "watch-history";
  static const String trackWatchHistory = "watch-history/track";

  // Notifications ذ
  static const String notifications = "notifications";
  static String notificationById(String id) => "notifications/$id";

  //Playlist
  static const String playlists = "playlists";

  // Profile
  static const String profileMe = "profile/me";
}
