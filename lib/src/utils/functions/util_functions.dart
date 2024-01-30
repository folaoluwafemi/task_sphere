import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

abstract final class UtilFunctions {
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static DateTime parseDateTime(
    dynamic data, {
    bool mustReturnDate = false,
  }) {
    try {
      if (data is Timestamp) {
        return data.toDate().toLocal();
      }
      return DateTime.parse(data).toLocal();
    } on FormatException {
      return DateTime.fromMillisecondsSinceEpoch(data as int);
    } catch (e, stackTrace) {
      if (mustReturnDate) return DateTime(DateTime.now().year);
      throw Failure(message: '$e', stackTrace: stackTrace);
    }
  }

  static List<DateTime> daysInMonth(
    int month, {
    int? year,
    int firstDayInMonth = 1,
    int? lastDayInMonth,
  }) {
    year ??= DateTime.now().year;

    final DateTime firstDayOfMonth = DateTime(year, month, firstDayInMonth);
    final DateTime lastDayOfMonth = lastDayInMonth != null
        ? DateTime(year, month, lastDayInMonth)
        : DateTime(year, month + 1, 0);

    final List<DateTime> days = [];

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    return days;
  }

  static List<List<DateTime>> weeksInMonth(
    int month, {
    int? year,
    int firstDayInMonth = 1,
    int? lastDayInMonth,
  }) {
    year ??= DateTime.now().year;

    final List<DateTime> days = daysInMonth(
      month,
      year: year,
      firstDayInMonth: firstDayInMonth,
      lastDayInMonth: lastDayInMonth,
    );

    final List<List<DateTime>> weeks = [];

    while (days.isNotEmpty) {
      final List<DateTime> week = [];
      final int indexOfLastDayOfCurrentWeek = days.indexWhere((element) {
        return element.weekday == DateTime.sunday;
      });

      if (indexOfLastDayOfCurrentWeek == -1) {
        weeks.add(days);
        break;
      }

      week.addAll(days.sublist(0, indexOfLastDayOfCurrentWeek + 1));
      days.removeRange(0, indexOfLastDayOfCurrentWeek + 1);

      weeks.add(week);
    }

    return weeks;
  }

  static String formatDateWithShortMonth(DateTime date) {
    final String month = Values.shortMonths[date.month];
    final String year = '${date.year}';
    return '$month $year';
  }

  static bool compareQueries(String value, String query) {
    final String formattedValue = value.trim().toLowerCase();
    final List<String> queryWords = query.split(' ');
    if (queryWords.length == 1) {
      return formattedValue.contains(query.trim().toLowerCase());
    }
    bool hasMatch = false;
    for (String queryWord in queryWords) {
      hasMatch = formattedValue.contains(queryWord.trim().toLowerCase());
      if (hasMatch) return true;
    }
    return false;
  }

  static String formatNumberInput(num number) {
    String trailingDecimal = '';
    if (number is double) trailingDecimal = '.${'$number'.split('.').last}';
    final String numText = number.toInt().toString();
    final int numLength = numText.length;

    String fullNumText = '';
    for (int i = _getHighestThreeMultiple(numLength); i >= 0; i -= 3) {
      bool onHighestPlaceValue = (_getHighestThreeMultiple(numLength) - i) < 3;
      bool onLowestPlaceValue = i <= 3;
      fullNumText += numText.substring(
        onHighestPlaceValue ? 0 : (numLength - i),
        onLowestPlaceValue ? null : numLength - (i - 3),
      );
      if (onLowestPlaceValue) return '$fullNumText$trailingDecimal';
      fullNumText += ',';
    }
    return '$fullNumText$trailingDecimal';
  }

  static int _getHighestThreeMultiple(int numString) {
    if (numString % 3 == 0) return numString;
    return numString + (3 - (numString % 3));
  }

  static String getTimeAgo(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);
    //todo increase precision
    if (difference.inDays > 365) return '${difference.inDays % 365}y';
    if (difference.inDays > 30) return '${difference.inDays % 30}m';
    if (difference.inDays > 0) return '${difference.inDays}d';
    if (difference.inHours > 0) return '${difference.inHours}hr';
    if (difference.inMinutes > 0) return '${difference.inHours}min';
    return 'now';
  }
}
