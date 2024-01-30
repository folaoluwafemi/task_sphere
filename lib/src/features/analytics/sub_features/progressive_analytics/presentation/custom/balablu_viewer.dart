part of 'progressive_analysis_builder.dart';

class CalendarViewer extends StatefulWidget {
  final List<ProductivitySnapshot> snapshots;

  const CalendarViewer({
    Key? key,
    required this.snapshots,
  }) : super(key: key);

  @override
  State<CalendarViewer> createState() => _CalendarViewerState();
}

typedef Week = List<DateTime>;
typedef Month = List<Week>;
typedef Year = List<Month>;

typedef WeeklySnapshots = Map<int, List<ProductivitySnapshot>>;
typedef MonthlySnapshots = Map<int, WeeklySnapshots>;
typedef YearlySnapshots = Map<int, MonthlySnapshots>;
typedef ProductivitySnapshots = List<ProductivitySnapshot>;

typedef SnapshotItem = MapEntry<DateTime, int>;
typedef MapSnapshot = Map<DateTime, int>;

extension on MapSnapshot {
  List<ProductivitySnapshot> toList() {
    return [
      for (final entry in entries) (dateTime: entry.key, value: entry.value),
    ];
  }
}

extension on ProductivitySnapshot {
  SnapshotItem toMapEntry() => MapEntry(dateTime, value);
}

class _CalendarViewerState extends State<CalendarViewer> {
  late final List<ProductivitySnapshot> snapshots = widget.snapshots
    ..sort(ProductivitySnapshotUtils.compare);
  late final Map<DateTime, ProductivitySnapshot> allSnapshots = {
    for (final snapshot in snapshots)
      snapshot.dateTime.copyWith(
        millisecond: 0,
        microsecond: 0,
        second: 0,
        minute: 0,
        hour: 0,
      ): (
        dateTime: snapshot.dateTime.copyWith(
          millisecond: 0,
          microsecond: 0,
          second: 0,
          minute: 0,
          hour: 0,
        ),
        value: snapshot.value
      ),
  };

  final YearlySnapshots yearlySnapshots = {};

  late final int maxValue = snapshots.fold(
    0,
    (previousValue, element) {
      return previousValue > element.value ? previousValue : element.value;
    },
  );

  static const int firstDayOfWeek = DateTime.monday;
  static const int lastDayOfWeek = DateTime.sunday;

  @override
  void initState() {
    super.initState();
    performMagic();
  }

  void performMagic() {
    final ProductivitySnapshots workingSnapshots = snapshots.copy;

    final List<int> years = [];

    while (workingSnapshots.isNotEmpty) {
      final int currentYear = workingSnapshots.first.dateTime.year;
      years.add(currentYear);
      workingSnapshots.removeWhere((element) {
        return element.dateTime.year == currentYear;
      });
    }
    for (int year in years) {
      yearlySnapshots[year] = getMonthsPartForYear(year);
    }
  }

  MonthlySnapshots getMonthsPartForYear(int year) {
    final firstSnapshotInFirstMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).first;

    final int firstMonthInYear = firstSnapshotInFirstMonth.dateTime.month;

    final lastSnapshotInLastMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).last;

    final int lastMonth = lastSnapshotInLastMonth.dateTime.month;

    final List<int> monthsInYear = [
      for (int i = firstMonthInYear; i <= lastMonth; i++) i
    ];
    final List<MapEntry<int, WeeklySnapshots>> monthsSnapshots = [];

    for (final month in monthsInYear) {
      final MapEntry<int, WeeklySnapshots> item = getWeeksPartForMonth(
        month: month,
        year: year,
        firstDayInMonth: firstSnapshotInFirstMonth.dateTime.day,
        lastDayInMonth:
            month == lastMonth ? lastSnapshotInLastMonth.dateTime.day : null,
      );
      monthsSnapshots.add(item);
    }

    return Map<int, WeeklySnapshots>.fromEntries(monthsSnapshots);
  }

  ProductivitySnapshot snapshotFromDay(DateTime day) {
    try {
      return allSnapshots[day]!;
    } catch (e) {
      print('error day: $day');
      rethrow;
    }
  }

  MonthlySnapshots balancedOutWeeksInYear(int year) {
    final firstSnapshotInFirstMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).first;

    final int firstMonthInYear = firstSnapshotInFirstMonth.dateTime.month;

    final lastSnapshotInLastMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).last;

    final int lastMonth = lastSnapshotInLastMonth.dateTime.month;

    final List<int> monthsInYear = [
      for (int i = firstMonthInYear; i <= lastMonth; i++) i
    ];

    Year year_ = getWeeksForMonth(year: year);
    year_ = balanceIncompleteWeeks(year_);

    return monthlySnapshotsFromYear(year_);
  }

  /// composes the [ProductivitySnapshot] value for each day in a [Week]
  /// in a [Month] in a [Year].
  MonthlySnapshots monthlySnapshotsFromYear(Year year) {
    final MonthlySnapshots monthlySnapshots = {};

    for (int i = 0; i < year.length; i++) {
      final WeeklySnapshots weeklySnapshots = {};
      final Month month = year[i];
      for (int i = 0; i < month.length; i++) {
        final ProductivitySnapshots snapshots = [];

        for (final DateTime day in month[i]) {
          snapshots.add(snapshotFromDay(day));
        }

        weeklySnapshots[i] = snapshots;
      }
      monthlySnapshots[i] = weeklySnapshots;
    }
    return monthlySnapshots;
  }

  /// If the first week in a [month] is not up to 7 days long,
  /// then the last week of the [previousMonth] is merged with the first of the [month].
  /// such that the first week of the [month] is up to 7 days long.
  /// and the last week of the [previousMonth] is up to 7 days long.
  Year balanceIncompleteWeeks(Year year) {
    year = year.copy;

    for (int i = 0; i < year.length; i++) {
      final Month month = year[i];
      if (month.first.length == 7) continue;
      if (i <= 0) continue;
      final Month previousMonth = year[i - 1];
      final Week lastWeekOfPreviousMonth = previousMonth.last;
      final Week firstWeekOfCurrentMonth = month.first;
      final Week freshMergedWeek = [
        ...lastWeekOfPreviousMonth,
        ...firstWeekOfCurrentMonth,
      ];
      final Month newMonth = [
        freshMergedWeek,
        ...month.sublist(1),
      ];

      // final Month oldMonth = previousMonth.copy..removeLast();

      year.insert(i, newMonth);
      year[i - 1].removeLast();
    }

    return year;
  }

  Year getWeeksForMonth({
    required int year,
  }) {
    final firstSnapshotInFirstMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).first;

    final int firstMonthInYear = firstSnapshotInFirstMonth.dateTime.month;

    final lastSnapshotInLastMonth = snapshots.where((element) {
      return element.dateTime.year == year;
    }).last;

    final int lastMonth = lastSnapshotInLastMonth.dateTime.month;

    final List<int> monthsInYear = [
      for (int i = firstMonthInYear; i <= lastMonth; i++) i
    ];

    final List<List<List<DateTime>>> items = [];

    for (final month in monthsInYear) {
      final List<List<DateTime>> item = UtilFunctions.weeksInMonth(
        month,
        year: year,
        firstDayInMonth: firstSnapshotInFirstMonth.dateTime.day,
        lastDayInMonth:
            month == lastMonth ? lastSnapshotInLastMonth.dateTime.day : null,
      );
      items.add(item);
    }
    return items;
  }

  MapEntry<int, WeeklySnapshots> getWeeksPartForMonth({
    required int month,
    required int year,
    required int firstDayInMonth,
    required int? lastDayInMonth,
  }) {
    final List<DateTime> daysInMonth = UtilFunctions.daysInMonth(
      month,
      year: year,
      firstDayInMonth: firstDayInMonth,
      lastDayInMonth: lastDayInMonth,
    );

    final Map<DateTime, ProductivitySnapshot> snapshotsInMonth = {};
    for (final day in daysInMonth) {
      snapshotsInMonth[day] = snapshotFromDay(day);
    }
    final List<List<DateTime>> weeksInMonth = UtilFunctions.weeksInMonth(
      month,
      year: year,
      firstDayInMonth: firstDayInMonth,
      lastDayInMonth: lastDayInMonth,
    );

    final WeeklySnapshots weeklySnapshots = {};
    for (int week = 0; week < weeksInMonth.length; week++) {
      weeklySnapshots[week + 1] = [
        for (final DateTime day in weeksInMonth[week]) snapshotsInMonth[day]!,
      ];
    }

    return MapEntry<int, WeeklySnapshots>(month, weeklySnapshots);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        YearlySnapshotWidget(
          maxValue: maxValue,
          yearlySnapshots: yearlySnapshots,
        ),
      ],
    );
  }
}
