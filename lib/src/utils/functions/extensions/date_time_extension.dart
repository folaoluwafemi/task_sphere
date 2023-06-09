part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String formatSimpleDate() {
    final intl.DateFormat format = intl.DateFormat.d().add_M().add_y();
    return format
        .format(this)
        .split(' ')
        .map((e) => e.toString().padLeft(2, '0'))
        .join(' ');
  }
}
