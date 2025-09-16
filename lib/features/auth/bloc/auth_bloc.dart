import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_to_goal/core/bloc/base_bloc.dart';
import 'package:note_to_goal/core/bloc/base_state.dart';
import 'package:note_to_goal/features/auth/bloc/auth_event.dart';
import 'package:note_to_goal/features/auth/bloc/auth_state.dart';
import 'package:note_to_goal/services/auth_service.dart';
import 'package:note_to_goal/shared/constants/app_constants.dart';
import 'package:note_to_goal/shared/exceptions/handled_exception.dart';

class AuthBloc extends BaseBloc<AuthUser> {
  AuthBloc() : super() {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthSessionCheckRequested>(_onSessionCheckRequested);
    on<AuthUserDataRequested>(_onUserDataRequested);
  }

  final AuthService _authService = AuthService.instance;

  @override
  Future<void> onInitialized(Emitter<BaseState<AuthUser>> emit) async {
    emit(AuthLoading());
    await _performSessionCheck(emit);
  }

  Future<void> _onSessionCheckRequested(
    AuthSessionCheckRequested event,
    Emitter<BaseState<AuthUser>> emit,
  ) async {
    emit(AuthLoading());
    await _performSessionCheck(emit);
  }

  Future<void> _performSessionCheck(Emitter<BaseState<AuthUser>> emit) async {
    try {
      final hasSession = await _authService.isAuthenticated();
      if (!hasSession) {
        emit(const AuthUnauthenticated());
        return;
      }

      final me = await _authService.me();
      final user = AuthUser.fromMap(me);
      emit(AuthAuthenticated(user));
    } on HandledException catch (error) {
      emit(AuthError(error.message, error: error));
    } catch (error) {
      emit(AuthError(error.toString(), error: error));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<BaseState<AuthUser>> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.login(email: event.email, password: event.password);
      final me = await _authService.me();
      final user = AuthUser.fromMap(me);
      emit(AuthAuthenticated(user));
    } on HandledException catch (error) {
      emit(AuthError(error.message, error: error));
    } catch (error) {
      emit(AuthError(AppConstants.errorGeneric, error: error));
    }
  }

  Future<void> _onUserDataRequested(
    AuthUserDataRequested event,
    Emitter<BaseState<AuthUser>> emit,
  ) async {
    try {
      final me = await _authService.me();
      final user = AuthUser.fromMap(me);
      emit(AuthAuthenticated(user));
    } on HandledException catch (error) {
      emit(AuthError(error.message, error: error));
    } catch (error) {
      emit(AuthError(AppConstants.errorGeneric, error: error));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<BaseState<AuthUser>> emit,
  ) async {
    emit(const AuthUnauthenticated());
  }
}
