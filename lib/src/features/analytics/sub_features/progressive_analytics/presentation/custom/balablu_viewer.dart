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

  final MonthlySnapshots monthlySnapshots = {};

  static const int firstDayOfWeek = DateTime.monday;
  static const int lastDayOfWeek = DateTime.sunday;

  void performMagic() {
    final SnapshotItem firstSnapshot =
        allSnapshots.entries.first.value.toMapEntry();
    final SnapshotItem lastSnapshotInFirstWeek = allSnapshots.entries
        .firstWhere((element) => element.key.weekday == lastDayOfWeek)
        .value
        .toMapEntry();

    final List<ProductivitySnapshots> monthlySnapshots = [];

    final int currentWeek = snapshots.first.dateTime.weekday;
    final int currentMonth = snapshots.first.dateTime.month;
    // for (DateTime i = snapshots.first.dateTime;
    //     i.isBefore(snapshots.last.dateTime);
    //     i.add(const Duration(days: 1))) {
    //   // if (i.weekday)
    // }
  }

  MonthlySnapshots getMonthsPartForYear(int year) {
    final int firstMonthInYear = snapshots
        .where((element) => element.dateTime.year == year)
        .first
        .dateTime
        .month;

    final List<int> monthsInYear = [
      for (int i = firstMonthInYear; i <= DateTime.monthsPerYear; i++) i
    ];
    final List<MapEntry<int, WeeklySnapshots>> monthsSnapshots = [
      for (final month in monthsInYear) getWeeksPartForMonth(month, year)
    ];

    return Map<int, WeeklySnapshots>.fromEntries(monthsSnapshots);
  }

  MapEntry<int, WeeklySnapshots> getWeeksPartForMonth(int month, int year) {
    final List<DateTime> daysInMonth = UtilFunctions.daysInMonth(
      month,
      year: year,
    );

    final Map<DateTime, ProductivitySnapshot> snapshotsInMonth = {
      for (final day in daysInMonth) day: allSnapshots[day]!,
    };

    final List<List<DateTime>> weeksInMonth = UtilFunctions.weeksInMonth(
      month,
      year: year,
    );

    final WeeklySnapshots weeklySnapshots = {};
    for (int week = 0; week < weeksInMonth.length; week++) {
      weeklySnapshots[week + 1] = [
        for (final DateTime day in weeksInMonth[week]) snapshotsInMonth[day]!,
      ];
    }

    return MapEntry<int, WeeklySnapshots>(month, weeklySnapshots);
  }

  balablu() {
    final DateTime normalizedDate = snapshots.last.dateTime.copyWith(
      day: 0,
      hour: 0,
      minute: 0,
      microsecond: 0,
      millisecond: 0,
      second: 0,
    );

    for (DateTime i = snapshots.first.dateTime;
        i.millisecondsSinceEpoch < normalizedDate.millisecondsSinceEpoch;
        i = i.copyAdd(months: 1)) {}
  }

  // MonthlySnapshots computeMonthSnapshotFrom()

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
