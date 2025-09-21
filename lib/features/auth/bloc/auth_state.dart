import 'package:dart_mappable/dart_mappable.dart';
import 'package:note_to_goal/core/bloc/base_state.dart';

part 'auth_state.mapper.dart';

@MappableClass()
class AuthUser with AuthUserMappable {
  const AuthUser({required this.id, required this.email, this.name});

  final String id;
  final String email;
  final String? name;

  static AuthUser fromMap(Map<String, dynamic> map) {
    final id = map['id']?.toString() ?? '';
    final email = map['email']?.toString() ?? '';
    final name = map['name']?.toString();
    return AuthUser(id: id, email: email, name: name);
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class AuthState extends BaseState<AuthUser> with AuthStateMappable {
  const AuthState();
}

@MappableClass()
class AuthUnauthenticated extends AuthState with AuthUnauthenticatedMappable {
  const AuthUnauthenticated();
}

@MappableClass()
class AuthAuthenticated extends AuthState with AuthAuthenticatedMappable {
  const AuthAuthenticated(this.user);
  final AuthUser user;
}

@MappableClass()
class AuthLoading extends AuthState with AuthLoadingMappable {
  const AuthLoading();
}

@MappableClass()
class AuthError extends AuthState with AuthErrorMappable {
  const AuthError(this.message, {this.error});
  final String message;
  final Object? error;
}
