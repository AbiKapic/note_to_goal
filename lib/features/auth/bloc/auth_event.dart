import 'package:dart_mappable/dart_mappable.dart';
import 'package:note_to_goal/core/bloc/base_event.dart';

part 'auth_event.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class AuthEvent extends BaseEvent with AuthEventMappable {
  const AuthEvent();
}

@MappableClass()
class AuthLoginRequested extends AuthEvent with AuthLoginRequestedMappable {
  const AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

@MappableClass()
class AuthLogoutRequested extends AuthEvent with AuthLogoutRequestedMappable {
  const AuthLogoutRequested();
}

@MappableClass()
class AuthSessionCheckRequested extends AuthEvent
    with AuthSessionCheckRequestedMappable {
  const AuthSessionCheckRequested();
}

@MappableClass()
class AuthUserDataRequested extends AuthEvent
    with AuthUserDataRequestedMappable {
  const AuthUserDataRequested();
}
