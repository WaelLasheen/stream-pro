import 'package:flutter/widgets.dart';

abstract class ShareService {
  Future<void> shareVideo(BuildContext context, {required String videoId});
}
