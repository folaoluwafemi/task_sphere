import 'package:task_sphere/src/utils/utils_barrel.dart';

typedef ProductivitySnapshot = ({DateTime dateTime, int value});

abstract final class ProductivitySnapshotUtils {
  static ProductivitySnapshot fromMap(Map<String, dynamic> map) {
    return (
      dateTime: UtilFunctions.parseDateTime(map['dateTime']),
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
