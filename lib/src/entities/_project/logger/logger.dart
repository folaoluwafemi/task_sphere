import 'package:logger/logger.dart';

abstract final class Log {
  static final Logger _logger = Logger();

  static void warning(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.w(message, error, stackTrace);
  }

  static void error(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.e(message, error, stackTrace);
  }

  static void debug(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.d(message, error, stackTrace);
  }

  static void info(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.i(message, error, stackTrace);
  }

  static void verbose(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.v(message, error, stackTrace);
  }

  static void escalatedError(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.wtf(message, error, stackTrace);
  }
}
