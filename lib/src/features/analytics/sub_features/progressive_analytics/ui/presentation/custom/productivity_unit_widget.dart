part of '../progressive_analytics_widget.dart';

enum ProductivityUnit {
  extra(100),
  high(75),
  medium(50),
  low(25),
  none(0),
  ;

  final int percentageLimit;

  const ProductivityUnit(this.percentageLimit);

  factory ProductivityUnit.fromValue(
    int value, {
    required int maxValue,
  }) {
    final double percentage = (value / maxValue) * 100;
    return switch (percentage) {
      > 75 => extra,
      > 50 => high,
      > 25 => medium,
      _ when value >= 1 => low,
      _ => none,
    };
  }

  Color fillColor(ProductivityColors palette) => switch (this) {
        extra => palette.high,
        high => palette.high.withOpacity(0.8),
        medium => palette.medium.withOpacity(0.8),
        low => palette.low,
        none => palette.none,
      };

  Color borderColor(ProductivityColors palette) => switch (this) {
        extra => palette.high,
        high => palette.high.withOpacity(0),
        medium => palette.medium.withOpacity(0),
        low => palette.medium.withOpacity(0 /*.2*/),
        none => palette.none,
      };

  Widget get widget => _ProductivityUnitWidget(unit: this);
}

class _ProductivityUnitWidget extends StatelessWidget {
  final ProductivityUnit unit;

  const _ProductivityUnitWidget({
    Key? key,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: unit.fillColor(context.palette.productivityColors),
        border: Border.all(
          width: 1.l,
          color: unit.borderColor(context.palette.productivityColors),
        ),
        borderRadius: Ui.circularBorder(2),
      ),
    );
  }
}
