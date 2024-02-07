part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  bool containsTimeWithinDay(DateTime time) => day == time.day;

  String formatSimpleDate() {
    final intl.DateFormat format = intl.DateFormat.d().add_M().add_y();
    return format
        .format(this)
        .split(' ')
        .map((e) => e.toString().padLeft(2, '0'))
        .join(' ');
  }

  bool isAfterOrAt(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  bool isBeforeOrAt(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  DateTime getTimeBetween(DateTime other) {
    final int initialMilliseconds = millisecondsSinceEpoch;
    final int finalMilliseconds = other.millisecondsSinceEpoch;
    final int max = math.max(initialMilliseconds, finalMilliseconds);
    final int min = math.min(initialMilliseconds, finalMilliseconds);

    final int difference = max - min;
    if (difference == 1) {
      return DateTime.fromMillisecondsSinceEpoch(min);
    }

    return DateTime.fromMillisecondsSinceEpoch(
      min + difference.half.round(),
    );
  }

  bool dateEquality(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  DateTime copySubtract({
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) {
    return DateTime(
      year - (years ?? 0),
      month - (months ?? 0),
      day - (days ?? 0),
      hour - (hours ?? 0),
      minute - (minutes ?? 0),
      second - (seconds ?? 0),
      millisecond - (milliseconds ?? 0),
      microsecond - (microseconds ?? 0),
    );
  }

  DateTime copyAdd({
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) {
    return DateTime(
      year + (years ?? 0),
      month + (months ?? 0),
      day + (days ?? 0),
      hour + (hours ?? 0),
      minute + (minutes ?? 0),
      second + (seconds ?? 0),
      millisecond + (milliseconds ?? 0),
      microsecond + (microseconds ?? 0),
    );
  }
}
