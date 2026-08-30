class ApiConstants {
  static const String baseURL = "https://stream-pro-ten.vercel.app/api/v1/";
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String feed = "feed";

  // Video Details & Interactions
  static String videoDetails(String videoId) => "videos/$videoId";
  static String likeVideo(String videoId) => "likes/$videoId";
  static String comments(String videoId) => "comments/$videoId";
  static String commentById(String commentId) => "comments/$commentId";

  // Owner Channels
  static const String ownerChannels = "owner/channels";
  static const String uploadChannelAvatar = "owner/channels/upload-avatar";
  static const String uploadChannelThumbnail = "owner/channels/upload-thumbnail";

  // Public Channel Endpoints
  static String channelDetails(String channelId) => "channels/$channelId";
  static String channelHome(String channelId) => "channels/$channelId/home";
  static String channelVideos(String channelId) => "channels/$channelId/videos";
  static String channelPlaylists(String channelId) => "channels/$channelId/playlists";
}
