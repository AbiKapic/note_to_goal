import 'dart:async';
import 'dart:io';

import 'package:note_to_goal/app.dart';
import 'package:note_to_goal/shared/constants/app_constants.dart';
import 'package:note_to_goal/shared/exceptions/handled_exception.dart';
import 'package:notetogoal_backend_client/notetogoal_backend_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AuthService {
  AuthService._internal()
    : _keyManager = FlutterAuthenticationKeyManager(),
      _client = Client(
        App.configApiBaseUrl,
        authenticationKeyManager: FlutterAuthenticationKeyManager(),
      );

  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  static AuthService get instance => _instance;

  // TODO: Uncomment when using real backend
  // final FlutterAuthenticationKeyManager _keyManager;
  final FlutterAuthenticationKeyManager _keyManager; // ignore: unused_field
  final Client _client;

  String? _refreshToken;

  Client get client => _client;

  Future<bool> isAuthenticated() async {
    // Mock authentication check for testing - TODO: Remove when backend is ready
    return _refreshToken != null && _refreshToken!.isNotEmpty;

    // Uncomment below for real backend connection
    // final key = await _keyManager.get();
    // return key != null && key.isNotEmpty;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return HandledException.guard(() async {
      // Mock authentication for testing - TODO: Remove when backend is ready
      await Future.delayed(const Duration(seconds: 1));

      if (email == 'abi' && password == 'kralj123') {
        return {
          'success': true,
          'message': 'Login successful',
          'refreshToken':
              'mock_refresh_token_abi_${DateTime.now().millisecondsSinceEpoch}',
          'user': {'id': '2', 'email': email, 'name': 'Abi'},
        };
      } else {
        throw HandledException(
          'Incorrect login credentials. Please check your username and password.',
        );
      }

      // Uncomment below for real backend connection
      /*
      final response = await _executeWithRetry<dynamic>(() async {
        return _client
            .callServerEndpoint<dynamic>('auth', 'login', <String, dynamic>{
              'email': email,
              'password': password,
            })
            .timeout(AppConstants.defaultTimeout);
      });

      final map = _asMap(response);
      _refreshToken = map['refreshToken'] as String?;
      return map;
      */
    });
  }

  Future<void> logout() async {
    return HandledException.guard(() async {
      // Mock logout for testing - TODO: Remove when backend is ready
      await Future.delayed(const Duration(seconds: 1));
      _refreshToken = null;

      // Uncomment below for real backend connection
      /*
      await _executeWithRetry<void>(() async {
        return _client
            .callServerEndpoint<void>('auth', 'logout', const <String, dynamic>{})
            .timeout(AppConstants.defaultTimeout);
      });
      */
    });
  }

  Future<Map<String, dynamic>> me() async {
    return HandledException.guard(() async {
      // Mock user data for testing - TODO: Remove when backend is ready
      await Future.delayed(const Duration(milliseconds: 500));
      return {
        'id': '2',
        'email': 'abi',
        'name': 'Abi',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // Uncomment below for real backend connection
      /*
      final response = await _executeWithRetry<dynamic>(() async {
        return _client
            .callServerEndpoint<dynamic>(
              'user',
              'me',
              const <String, dynamic>{},
            )
            .timeout(AppConstants.defaultTimeout);
      });
      return _asMap(response);
      */
    });
  }

  Future<Map<String, dynamic>> refresh() async {
    return HandledException.guard(() async {
      if (_refreshToken == null || _refreshToken!.isEmpty) {
        throw HandledException(AppConstants.errorUnauthorized);
      }

      final response = await _executeWithRetry<dynamic>(() async {
        return _client
            .callServerEndpoint<dynamic>('auth', 'refresh', <String, dynamic>{
              'refreshToken': _refreshToken,
            })
            .timeout(AppConstants.defaultTimeout);
      }, authRetry: false);

      final map = _asMap(response);
      _refreshToken = map['refreshToken'] as String? ?? _refreshToken;
      return map;
    });
  }

  Future<T> _executeWithRetry<T>(
    Future<T> Function() action, {
    bool authRetry = true,
  }) async {
    int attempt = 0;
    while (true) {
      try {
        return await action();
      } on TimeoutException catch (_) {
        attempt++;
        if (attempt >= AppConstants.maxRetryCount) {
          throw HandledException(AppConstants.errorTimeout);
        }
        continue;
      } on SocketException catch (_) {
        attempt++;
        if (attempt >= AppConstants.maxRetryCount) {
          throw HandledException(AppConstants.errorNetwork);
        }
        continue;
      } on ServerpodClientException catch (error) {
        if (_isUnauthorized(error) && authRetry) {
          await refresh();
          return await _executeWithRetry(action, authRetry: false);
        }
        throw HandledException.fromException(error);
      } catch (error) {
        if (_looksUnauthorized(error) && authRetry) {
          await refresh();
          return await _executeWithRetry(action, authRetry: false);
        }
        throw HandledException.fromException(error);
      }
    }
  }

  bool _isUnauthorized(ServerpodClientException error) {
    final code = error.statusCode;
    return code == HttpStatus.unauthorized || code == 401;
  }

  bool _looksUnauthorized(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains('unauthorized') || message.contains('401');
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return <String, dynamic>{};
  }
}
