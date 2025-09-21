import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_to_goal/app.dart';
import 'package:note_to_goal/core/bloc/app_bloc_observer.dart';

const String flavor = 'prod';
const String apiBaseUrl = 'https://api.example.com';
const bool enableDebugFeatures = false;
const bool enableAnalytics = true;
const bool enableCrashReporting = true;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Bloc.observer = AppBlocObserver();

      FlutterError.onError = (FlutterErrorDetails details) {
        if (enableCrashReporting) {
          developer.log(
            'Production Error: ${details.exception}',
            name: 'CrashReport',
            error: details.exception,
            stackTrace: details.stack,
          );
        }
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        if (enableCrashReporting) {
          developer.log(
            'Production Platform Error: $error',
            name: 'CrashReport',
            error: error,
            stackTrace: stack,
          );
        }
        return false;
      };

      runApp(App(apiBaseUrl: apiBaseUrl));
    },
    (error, stackTrace) {
      if (enableCrashReporting) {
        developer.log(
          'Production Uncaught Error: $error',
          name: 'CrashReport',
          error: error,
          stackTrace: stackTrace,
        );
      }
    },
  );
}
