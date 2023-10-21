import 'package:logger/logger.dart';

class Log {
  static final _l = Logger(
    printer: PrettyPrinter(
        noBoxingByDefault: true,
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 0, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  static get d => _l.d;
  static get e => _l.e;
  static get i => _l.i;
  static get w => _l.w;
}
