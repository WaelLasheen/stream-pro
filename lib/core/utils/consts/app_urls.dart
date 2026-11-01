abstract class AppUrls {
  static const String webBaseUrl = 'https://stream-pro-frontend.vercel.app';

  static String video(String videoId) => '$webBaseUrl/videos/$videoId';
}
