import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_to_goal/app.dart';
import 'package:note_to_goal/core/bloc/app_bloc_observer.dart';

const String flavor = 'dev';
const String apiBaseUrl = 'https://dev-api.example.com';
const bool enableDebugFeatures = true;
const bool enableAnalytics = false;
const bool enableCrashReporting = false;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Bloc.observer = AppBlocObserver();

      if (kDebugMode) {
        developer.log('Development environment initialized', name: 'App');
        developer.log('Flavor: $flavor', name: 'App');
        developer.log('API Base URL: $apiBaseUrl', name: 'App');
        developer.log('BLoC Observer registered', name: 'App');
      }

      FlutterError.onError = (FlutterErrorDetails details) {
        if (kDebugMode) {
          developer.log(
            'Flutter Error: ${details.exception}',
            name: 'FlutterError',
            error: details.exception,
            stackTrace: details.stack,
          );
          FlutterError.dumpErrorToConsole(details);
        }
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        if (kDebugMode) {
          developer.log(
            'Platform Error: $error',
            name: 'PlatformError',
            error: error,
            stackTrace: stack,
          );
        }
        return false;
      };

      runApp(const App());
    },
    (error, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Uncaught Error: $error',
          name: 'UncaughtError',
          error: error,
          stackTrace: stackTrace,
        );
      }
    },
  );
}
