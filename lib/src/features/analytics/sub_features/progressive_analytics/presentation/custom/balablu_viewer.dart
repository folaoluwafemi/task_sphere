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
    final List<MapEntry<int, WeeklySnapshots>> monthsSnapshots = [
      for (final month in monthsInYear)
        getWeeksPartForMonth(
          month: month,
          year: year,
          firstDayInMonth: firstSnapshotInFirstMonth.dateTime.day,
          lastDayInMonth:
              month == lastMonth ? lastSnapshotInLastMonth.dateTime.day : null,
        )
    ];

    return Map<int, WeeklySnapshots>.fromEntries(monthsSnapshots);
  }

  ProductivitySnapshot balablu(DateTime day) {
    try {
      return allSnapshots[day]!;
    } catch (e) {
      print('error day: $day');
      rethrow;
    }
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
      snapshotsInMonth[day] = balablu(day);
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
