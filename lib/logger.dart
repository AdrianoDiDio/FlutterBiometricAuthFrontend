import 'package:biometric_auth_frontend/filters/release_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(filter: kDebugMode ? DevelopmentFilter() : ReleaseFilter());
