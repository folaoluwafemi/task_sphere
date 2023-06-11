part of 'extensions.dart';

extension StringExtension on String {
  String toFirstUpperCase() {
    if (isEmpty) return '';
    if (length == 1) return toUpperCase();
    final List<String> charsList = chars;

    final String first = charsList.first;
    final String remainingChars = charsList.join().replaceFirst(first, '');

    return '${first.toUpperCase()}$remainingChars';
  }

  String get cleanLower => trim().toLowerCase();

  String get cleanUpper => trim().toUpperCase();

  String removeAll(String pattern) {
    return replaceAll(pattern, '');
  }

  String removeAtLast(String pattern) {
    if (chars.last == pattern) {
      return substring(0, length - 1);
    }
    return this;
  }

  String removeAllAtLast(List<String> patterns) {
    String result = this;
    for (final String pattern in patterns) {
      result = result.removeAtLast(pattern);
      return result;
    }
    return result;
  }

  List<String> get words => split(' ');

  String toEachFirstUpperCase() {
    if (isEmpty) return '';
    if (length == 1) return toUpperCase();
    final List<String> upperWords = words.map((e) {
      return e.toFirstUpperCase();
    }).toList();
    return upperWords.join(' ');
  }

  String get linesRemoved => removeAll('\n');

  List<String> get chars => split('');

  String withExcludeParam(String param) {
    final String queryParam = 'exclude=$param';
    return addParam(queryParam);
  }

  String addParam(String param) {
    if (contains('?')) return '$this&$param';
    return '$this?$param';
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;
}
