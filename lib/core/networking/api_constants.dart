class ApiConstants {
  static const String baseURL = "http://192.168.0.104:3000/api/v1/";
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String feed = "feed";

  // Video Details & Interactions
  static String videoDetails(String videoId) => "videos/$videoId";
  static String likeVideo(String videoId) => "likes/$videoId";
  static String comments(String videoId) => "comments/$videoId";
  static String commentById(String commentId) => "comments/$commentId";
}
