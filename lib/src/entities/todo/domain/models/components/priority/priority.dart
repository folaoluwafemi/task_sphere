import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'priority_widget.dart';

enum Priority {
  low(1, VectorAssets.priorityLow, 'Low Priority'),
  medium(2, VectorAssets.priorityMedium, 'Medium Priority'),
  high(3, VectorAssets.priorityHigh, 'High Priority');

  final String? vectorAsset;
  final String? text;
  final int value;

  const Priority(this.value, [this.vectorAsset, this.text]);

  Widget get widgetSmall => _PriorityWidget.small(priority: this);

  Widget widgetWithDimension(double dimension) => _PriorityWidget.customSize(
        size: dimension,
        priority: this,
      );

  Widget get widgetLarge => _PriorityWidget.large(priority: this);

  Color? colorFromPalette(AlertColors alerts) => switch (this) {
        low => alerts.success,
        medium => alerts.info,
        high => alerts.error,
      };

  factory Priority.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'low' => low,
      'medium' => medium,
      'high' => high,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
