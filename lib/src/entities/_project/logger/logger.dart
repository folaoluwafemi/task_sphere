import 'package:flutter/foundation.dart';

abstract final class Log {
  static void warning(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }

  static void error(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }

  static void debug(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }

  static void info(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }

  static void verbose(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }

  static void escalatedError(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    debugPrint("$message\n\n$error\n\n$stackTrace\n");
  }
}
