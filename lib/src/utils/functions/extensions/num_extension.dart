part of 'extensions.dart';

extension AppSizerDoubleExtension on num {
  double get w => this * ResponsivenessSizer().widthScale;

  double get h => this * ResponsivenessSizer().heightScale;

  double get sp => this * ResponsivenessSizer().widthScale;

  double get l => max(w, h);

  double get m => min(w, h);

  SizedBox get boxWidth => SizedBox(width: w);

  SizedBox get boxHeight => SizedBox(height: h);

  double get spMin => min(toDouble(), sp);

  double get spMax => max(toDouble(), sp);
}
