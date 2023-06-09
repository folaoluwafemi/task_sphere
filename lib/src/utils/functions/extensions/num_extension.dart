part of 'extensions.dart';

extension AppSizerDoubleExtension on num {
  double get l => math.max(w, h);

  double get m => math.min(w, h);

  SizedBox get boxWidth => SizedBox(width: w);

  SizedBox get boxHeight => SizedBox(height: h);

  double get half => this / 2;

  double percent(double value) => this * value / 100;

  double ratio(double value) => this * value;

  double get radians => this * (math.pi / 180);

  double get pi => this * math.pi;
}
