import 'package:task_sphere/src/utils/utils_barrel.dart';

typedef ProductivitySnapshot = ({DateTime dateTime, int value});

abstract final class ProductivitySnapshotUtils {
  static ProductivitySnapshot get empty => (
        dateTime: DateTime.now(),
        value: 0,
      );

  static int compare(ProductivitySnapshot a, ProductivitySnapshot b) {
    return a.dateTime.compareTo(b.dateTime);
  }

  static ProductivitySnapshot fromMap(Map<String, dynamic> map) {
    return (
      dateTime: map['dateTime'] is DateTime
          ? map['dateTime']!
          : UtilFunctions.parseDateTime(map['dateTime']),
      value: map['value'],
    );
  }
}

extension ProductivitySnapshotExtension on ProductivitySnapshot {
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'value': value,
    };
  }
}
