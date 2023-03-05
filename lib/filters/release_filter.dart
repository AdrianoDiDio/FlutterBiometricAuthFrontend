import 'package:logger/logger.dart';

class ReleaseFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level.index > Level.debug.index;
  }
}
