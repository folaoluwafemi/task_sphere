import 'package:flutter/foundation.dart';

abstract class Validators {
  static String? simpleValidator(
    String? value, {
    ValueChanged<bool>? onValidated,
  }) {
    if (value?.isEmpty ?? true) {
      onValidated?.call(false);
      return null;
    }
    onValidated?.call(true);
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    String password, {
    ValueChanged<bool>? onValidated,
  }) {
    if (value?.isEmpty ?? true) {
      onValidated?.call(false);
      return 'Field cannot be empty!';
    }
    if (value != password) {
      onValidated?.call(false);
      return 'must be equal with above password!';
    }
    onValidated?.call(true);
    return null;
  }

  static String? emailValidator(
    value, {
    ValueChanged<bool>? onValidated,
  }) {
    final RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    bool hasMatch = regExp.hasMatch('$value');
    if (value == null || !hasMatch) {
      onValidated?.call(false);
      return null;
    }
    onValidated?.call(true);
    return null;
  }
}
