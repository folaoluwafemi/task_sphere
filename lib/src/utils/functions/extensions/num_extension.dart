part of 'extensions.dart';

extension AppSizerDoubleExtension on num {
  double get w => this * ResponsivenessSizer().widthScale;

  double get h => this * ResponsivenessSizer().heightScale;

  double get sp => this * ResponsivenessSizer().widthScale;

  double get r => min(
        ResponsivenessSizer().widthScale,
        ResponsivenessSizer().heightScale,
      );

  SizedBox get boxWidth => SizedBox(width: w);

  SizedBox get boxHeight {
    print('screen height: ${ResponsivenessSizer().screenHeight}');
    return SizedBox(height: h);
  }

  double get spMin => min(toDouble(), sp);

  double get spMax => max(toDouble(), sp);
}
