import 'package:intl/intl.dart';

class NotificationDateFormatter {
  NotificationDateFormatter._();

  static String format(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // أقل من يوم
    if (difference.inHours < 24) {
      return DateFormat('HH:mm').format(date);
    }

    // أقل من أسبوع
    if (difference.inDays < 7) {
      return DateFormat('EEE').format(date); // Mon, Tue...
    }

    // أقدم من أسبوع
    return DateFormat('dd MMM').format(date); // 10 Jul
  }
}
