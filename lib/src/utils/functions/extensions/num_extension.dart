part of 'extensions.dart';

extension AppSizerDoubleExtension on num {
  double get l => math.max(w, h);

  double get m => math.min(w, h);

  SizedBox get boxWidth => SizedBox(width: w);

  SizedBox get boxHeight => SizedBox(height: h);

  double get half => this / 2;

  double get sixth => this / 6;

  double get third => this / 3;

  double get twoThirds => this * 2 / 3;

  double get doubled => this * 2;

  double percent(double value) => this * value / 100;

  double ratio(double value) => this * value;

  double get toRadians => this * (math.pi / 180);

  double get pi => this * math.pi;

  double bezierRelativeWidth(double newWidth) {
    return this * (newWidth / 107.7.w);
  }

  bool isAround(num other, {double offBy = 2}) {
    return other >= this - 2 && other < (this + 2);
  }

  double bezierRelativeHeight(double newHeight) {
    return this * (newHeight / 37.3.w);
  }
}

extension GenericNumExtension<T extends num> on T {
  T capAt(T cap) => this > cap ? cap : this;

  T capBetween(T min, T max) => this > max
      ? max
      : this < min
          ? min
          : this;
}
