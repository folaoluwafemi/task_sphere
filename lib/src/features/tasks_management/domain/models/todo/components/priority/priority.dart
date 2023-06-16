import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'priority_widget.dart';

enum Priority {
  none,
  low(VectorAssets.priorityLow, 'Low Priority'),
  medium(VectorAssets.priorityMedium, 'Medium Priority'),
  high(VectorAssets.priorityHigh, 'High Priority');

  final String? vectorAsset;
  final String? text;

  const Priority([this.vectorAsset, this.text]);

  Widget get widgetSmall => this == none
      ? const SizedBox.shrink()
      : _PriorityWidget.small(priority: this);

  Widget widgetWithDimension(double dimension) => this == none
      ? const SizedBox.shrink()
      : _PriorityWidget.customSize(size: dimension, priority: this);

  Widget get widgetLarge => this == none
      ? const SizedBox.shrink()
      : _PriorityWidget.large(priority: this);

  Color? colorFromPalette(AlertColors alerts) => switch (this) {
        none => null,
        low => alerts.success,
        medium => alerts.info,
        high => alerts.error,
      };

  factory Priority.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'none' => none,
      'low' => low,
      'medium' => medium,
      'high' => high,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
