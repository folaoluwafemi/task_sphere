part of 'extensions.dart';

extension AppSizerDoubleExtension on num {
  double get l => math.max(w, h);

  double get m => math.min(w, h);

  SizedBox get boxWidth => SizedBox(width: w);

  SizedBox get boxHeight => SizedBox(height: h);

  SliverToBoxAdapter get sliverBoxWidth => SliverToBoxAdapter(
        child: SizedBox(width: w),
      );

  SliverToBoxAdapter get sliverBoxHeight => SliverToBoxAdapter(
        child: SizedBox(height: h),
      );

  double get half => this / 2;

  double get sixth => this / 6;

  double get third => this / 3;

  double get twoThirds => this * 2 / 3;

  double get doubled => this * 2;

  double percent(double value) => this * value / 100;

  double ratio(double value) => this * value;

  double get toRadians => this * (math.pi / 180);

  double get pi => this * math.pi;

  num get oneIfZero => this == 0 ? 1 : this;

  int get zeroIfLess => this < 0 ? 0 : (this as int);

  double? get nullIfZero => this == 0 ? null : (this as double);

  double bezierRelativeWidth(double newWidth) {
    return this * (newWidth / 107.7.w);
  }

  bool isAround(num other, {double offBy = 2}) {
    return other >= this - 2 && other < (this + 2);
  }

  bool isAroundOrGreaterThan(num other, {double offBy = 2}) {
    return this >= other + 2 || isAround(other, offBy: offBy);
  }

  bool isAroundOrLessThan(num other, {double offBy = 2}) {
    return this <= other - 2 || isAround(other, offBy: offBy);
  }

  double bezierRelativeHeight(double newHeight) {
    return this * (newHeight / 37.3.w);
  }

  String toOrdinal() {
    final int number = toInt();
    final int remainder = number % 100;

    if (remainder >= 11 && remainder <= 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  String get pluralS {
    if (this == 1) {
      return '';
    }
    return 's';
  }
}

extension IntExtension on int {
  List<int> range([int start = 1]) => List<int>.generate(
        this,
        (int index) => index + start,
      );

  Duration get seconds => Duration(seconds: this);
}

extension GenericNumExtension<T extends num> on T {
  T capAt(T cap) => this >= cap ? cap : this;

  T capBetween(T min, T max) => this >= max
      ? max
      : this <= min
          ? min
          : this;
}
