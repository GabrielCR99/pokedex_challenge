import 'dart:io' as io;

import 'package:logger/logger.dart';

import 'app_logger.dart';

final class AppLoggerImpl implements AppLogger {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: io.stdout.hasTerminal ? io.stdout.terminalColumns : 140,
      printEmojis: false,
      printTime: true,
    ),
  );

  var _messages = <String>[];

  @override
  void debug(Object? message, [Object? error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  @override
  void error(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  @override
  void info(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  @override
  void warning(Object? message, [Object? error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void append(Object? message) => _messages.add(message! as String);

  @override
  void closeAppend({bool isError = false}) {
    isError ? error(_messages.join('\n')) : info(_messages.join('\n'));
    _messages = <String>[];
  }
}
