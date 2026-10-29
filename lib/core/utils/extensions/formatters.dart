import 'package:stream_pro/generated/l10n.dart';

extension FormatCount on int {
  String formatCount() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}${S.current.million}';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}${S.current.thousand}';
    } else {
      return toString();
    }
  }

  String formatDuration() {
    final duration = Duration(seconds: this);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (duration.inHours > 0) {
      return '${duration.inHours}:$minutes:$secs';
    }
    return '$minutes:$secs';
  }
}

extension FormatTime on DateTime {
  String timeAgo() {
    final diff = DateTime.now().difference(this);
    if (diff.inDays > 365)
      return '${(diff.inDays / 365).floor()}${S.current.yearsAgo}';
    if (diff.inDays > 30)
      return '${(diff.inDays / 30).floor()}${S.current.monthsAgo}';
    if (diff.inDays > 0) return '${diff.inDays}${S.current.daysAgo}';
    if (diff.inHours > 0) return '${diff.inHours}${S.current.hoursAgo}';
    if (diff.inMinutes > 0) return '${diff.inMinutes}${S.current.minutesAgo}';
    return S.current.justNow;
  }
}

extension FormatWords on String {
  String formatWords() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
