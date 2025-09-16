// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_state.dart';

class AuthUserMapper extends ClassMapperBase<AuthUser> {
  AuthUserMapper._();

  static AuthUserMapper? _instance;
  static AuthUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUser';

  static String _$id(AuthUser v) => v.id;
  static const Field<AuthUser, String> _f$id = Field('id', _$id);
  static String _$email(AuthUser v) => v.email;
  static const Field<AuthUser, String> _f$email = Field('email', _$email);
  static String? _$name(AuthUser v) => v.name;
  static const Field<AuthUser, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<AuthUser> fields = const {
    #id: _f$id,
    #email: _f$email,
    #name: _f$name,
  };

  static AuthUser _instantiate(DecodingData data) {
    return AuthUser(
        id: data.dec(_f$id),
        email: data.dec(_f$email),
        name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUser>(map);
  }

  static AuthUser fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUser>(json);
  }
}

mixin AuthUserMappable {
  String toJson() {
    return AuthUserMapper.ensureInitialized()
        .encodeJson<AuthUser>(this as AuthUser);
  }

  Map<String, dynamic> toMap() {
    return AuthUserMapper.ensureInitialized()
        .encodeMap<AuthUser>(this as AuthUser);
  }

  AuthUserCopyWith<AuthUser, AuthUser, AuthUser> get copyWith =>
      _AuthUserCopyWithImpl(this as AuthUser, $identity, $identity);
  @override
  String toString() {
    return AuthUserMapper.ensureInitialized().stringifyValue(this as AuthUser);
  }

  @override
  bool operator ==(Object other) {
    return AuthUserMapper.ensureInitialized()
        .equalsValue(this as AuthUser, other);
  }

  @override
  int get hashCode {
    return AuthUserMapper.ensureInitialized().hashValue(this as AuthUser);
  }
}

extension AuthUserValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthUser, $Out> {
  AuthUserCopyWith<$R, AuthUser, $Out> get $asAuthUser =>
      $base.as((v, t, t2) => _AuthUserCopyWithImpl(v, t, t2));
}

abstract class AuthUserCopyWith<$R, $In extends AuthUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? email, String? name});
  AuthUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUser, $Out>
    implements AuthUserCopyWith<$R, AuthUser, $Out> {
  _AuthUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUser> $mapper =
      AuthUserMapper.ensureInitialized();
  @override
  $R call({String? id, String? email, Object? name = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (email != null) #email: email,
        if (name != $none) #name: name
      }));
  @override
  AuthUser $make(CopyWithData data) => AuthUser(
      id: data.get(#id, or: $value.id),
      email: data.get(#email, or: $value.email),
      name: data.get(#name, or: $value.name));

  @override
  AuthUserCopyWith<$R2, AuthUser, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthUserCopyWithImpl($value, $cast, t);
}

class AuthStateMapper extends SubClassMapperBase<AuthState> {
  AuthStateMapper._();

  static AuthStateMapper? _instance;
  static AuthStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateMapper._());
      BaseStateMapper.ensureInitialized().addSubMapper(_instance!);
      AuthUnauthenticatedMapper.ensureInitialized();
      AuthAuthenticatedMapper.ensureInitialized();
      AuthLoadingMapper.ensureInitialized();
      AuthErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthState';

  @override
  final MappableFields<AuthState> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthState';
  @override
  late final ClassMapperBase superMapper = BaseStateMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static AuthState _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'AuthState', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthState>(map);
  }

  static AuthState fromJson(String json) {
    return ensureInitialized().decodeJson<AuthState>(json);
  }
}

mixin AuthStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthStateCopyWith<AuthState, AuthState, AuthState> get copyWith;
}

abstract class AuthStateCopyWith<$R, $In extends AuthState, $Out>
    implements BaseStateCopyWith<$R, $In, $Out, AuthUser> {
  @override
  $R call();
  AuthStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthUnauthenticatedMapper
    extends SubClassMapperBase<AuthUnauthenticated> {
  AuthUnauthenticatedMapper._();

  static AuthUnauthenticatedMapper? _instance;
  static AuthUnauthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUnauthenticatedMapper._());
      AuthStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUnauthenticated';

  @override
  final MappableFields<AuthUnauthenticated> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthUnauthenticated';
  @override
  late final ClassMapperBase superMapper = AuthStateMapper.ensureInitialized();

  static AuthUnauthenticated _instantiate(DecodingData data) {
    return AuthUnauthenticated();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUnauthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUnauthenticated>(map);
  }

  static AuthUnauthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUnauthenticated>(json);
  }
}

mixin AuthUnauthenticatedMappable {
  String toJson() {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .encodeJson<AuthUnauthenticated>(this as AuthUnauthenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .encodeMap<AuthUnauthenticated>(this as AuthUnauthenticated);
  }

  AuthUnauthenticatedCopyWith<AuthUnauthenticated, AuthUnauthenticated,
          AuthUnauthenticated>
      get copyWith => _AuthUnauthenticatedCopyWithImpl(
          this as AuthUnauthenticated, $identity, $identity);
  @override
  String toString() {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .stringifyValue(this as AuthUnauthenticated);
  }

  @override
  bool operator ==(Object other) {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .equalsValue(this as AuthUnauthenticated, other);
  }

  @override
  int get hashCode {
    return AuthUnauthenticatedMapper.ensureInitialized()
        .hashValue(this as AuthUnauthenticated);
  }
}

extension AuthUnauthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUnauthenticated, $Out> {
  AuthUnauthenticatedCopyWith<$R, AuthUnauthenticated, $Out>
      get $asAuthUnauthenticated =>
          $base.as((v, t, t2) => _AuthUnauthenticatedCopyWithImpl(v, t, t2));
}

abstract class AuthUnauthenticatedCopyWith<$R, $In extends AuthUnauthenticated,
    $Out> implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthUnauthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthUnauthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUnauthenticated, $Out>
    implements AuthUnauthenticatedCopyWith<$R, AuthUnauthenticated, $Out> {
  _AuthUnauthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUnauthenticated> $mapper =
      AuthUnauthenticatedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthUnauthenticated $make(CopyWithData data) => AuthUnauthenticated();

  @override
  AuthUnauthenticatedCopyWith<$R2, AuthUnauthenticated, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthUnauthenticatedCopyWithImpl($value, $cast, t);
}

class AuthAuthenticatedMapper extends SubClassMapperBase<AuthAuthenticated> {
  AuthAuthenticatedMapper._();

  static AuthAuthenticatedMapper? _instance;
  static AuthAuthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthAuthenticatedMapper._());
      AuthStateMapper.ensureInitialized().addSubMapper(_instance!);
      AuthUserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthAuthenticated';

  static AuthUser _$user(AuthAuthenticated v) => v.user;
  static const Field<AuthAuthenticated, AuthUser> _f$user =
      Field('user', _$user);

  @override
  final MappableFields<AuthAuthenticated> fields = const {
    #user: _f$user,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthAuthenticated';
  @override
  late final ClassMapperBase superMapper = AuthStateMapper.ensureInitialized();

  static AuthAuthenticated _instantiate(DecodingData data) {
    return AuthAuthenticated(data.dec(_f$user));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthAuthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthAuthenticated>(map);
  }

  static AuthAuthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<AuthAuthenticated>(json);
  }
}

mixin AuthAuthenticatedMappable {
  String toJson() {
    return AuthAuthenticatedMapper.ensureInitialized()
        .encodeJson<AuthAuthenticated>(this as AuthAuthenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthAuthenticatedMapper.ensureInitialized()
        .encodeMap<AuthAuthenticated>(this as AuthAuthenticated);
  }

  AuthAuthenticatedCopyWith<AuthAuthenticated, AuthAuthenticated,
          AuthAuthenticated>
      get copyWith => _AuthAuthenticatedCopyWithImpl(
          this as AuthAuthenticated, $identity, $identity);
  @override
  String toString() {
    return AuthAuthenticatedMapper.ensureInitialized()
        .stringifyValue(this as AuthAuthenticated);
  }

  @override
  bool operator ==(Object other) {
    return AuthAuthenticatedMapper.ensureInitialized()
        .equalsValue(this as AuthAuthenticated, other);
  }

  @override
  int get hashCode {
    return AuthAuthenticatedMapper.ensureInitialized()
        .hashValue(this as AuthAuthenticated);
  }
}

extension AuthAuthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthAuthenticated, $Out> {
  AuthAuthenticatedCopyWith<$R, AuthAuthenticated, $Out>
      get $asAuthAuthenticated =>
          $base.as((v, t, t2) => _AuthAuthenticatedCopyWithImpl(v, t, t2));
}

abstract class AuthAuthenticatedCopyWith<$R, $In extends AuthAuthenticated,
    $Out> implements AuthStateCopyWith<$R, $In, $Out> {
  AuthUserCopyWith<$R, AuthUser, AuthUser> get user;
  @override
  $R call({AuthUser? user});
  AuthAuthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthAuthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthAuthenticated, $Out>
    implements AuthAuthenticatedCopyWith<$R, AuthAuthenticated, $Out> {
  _AuthAuthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthAuthenticated> $mapper =
      AuthAuthenticatedMapper.ensureInitialized();
  @override
  AuthUserCopyWith<$R, AuthUser, AuthUser> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  $R call({AuthUser? user}) =>
      $apply(FieldCopyWithData({if (user != null) #user: user}));
  @override
  AuthAuthenticated $make(CopyWithData data) =>
      AuthAuthenticated(data.get(#user, or: $value.user));

  @override
  AuthAuthenticatedCopyWith<$R2, AuthAuthenticated, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthAuthenticatedCopyWithImpl($value, $cast, t);
}

class AuthLoadingMapper extends SubClassMapperBase<AuthLoading> {
  AuthLoadingMapper._();

  static AuthLoadingMapper? _instance;
  static AuthLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthLoadingMapper._());
      AuthStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthLoading';

  @override
  final MappableFields<AuthLoading> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthLoading';
  @override
  late final ClassMapperBase superMapper = AuthStateMapper.ensureInitialized();

  static AuthLoading _instantiate(DecodingData data) {
    return AuthLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthLoading>(map);
  }

  static AuthLoading fromJson(String json) {
    return ensureInitialized().decodeJson<AuthLoading>(json);
  }
}

mixin AuthLoadingMappable {
  String toJson() {
    return AuthLoadingMapper.ensureInitialized()
        .encodeJson<AuthLoading>(this as AuthLoading);
  }

  Map<String, dynamic> toMap() {
    return AuthLoadingMapper.ensureInitialized()
        .encodeMap<AuthLoading>(this as AuthLoading);
  }

  AuthLoadingCopyWith<AuthLoading, AuthLoading, AuthLoading> get copyWith =>
      _AuthLoadingCopyWithImpl(this as AuthLoading, $identity, $identity);
  @override
  String toString() {
    return AuthLoadingMapper.ensureInitialized()
        .stringifyValue(this as AuthLoading);
  }

  @override
  bool operator ==(Object other) {
    return AuthLoadingMapper.ensureInitialized()
        .equalsValue(this as AuthLoading, other);
  }

  @override
  int get hashCode {
    return AuthLoadingMapper.ensureInitialized().hashValue(this as AuthLoading);
  }
}

extension AuthLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthLoading, $Out> {
  AuthLoadingCopyWith<$R, AuthLoading, $Out> get $asAuthLoading =>
      $base.as((v, t, t2) => _AuthLoadingCopyWithImpl(v, t, t2));
}

abstract class AuthLoadingCopyWith<$R, $In extends AuthLoading, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthLoading, $Out>
    implements AuthLoadingCopyWith<$R, AuthLoading, $Out> {
  _AuthLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthLoading> $mapper =
      AuthLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthLoading $make(CopyWithData data) => AuthLoading();

  @override
  AuthLoadingCopyWith<$R2, AuthLoading, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthLoadingCopyWithImpl($value, $cast, t);
}

class AuthErrorMapper extends SubClassMapperBase<AuthError> {
  AuthErrorMapper._();

  static AuthErrorMapper? _instance;
  static AuthErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthErrorMapper._());
      AuthStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthError';

  static String _$message(AuthError v) => v.message;
  static const Field<AuthError, String> _f$message =
      Field('message', _$message);
  static Object? _$error(AuthError v) => v.error;
  static const Field<AuthError, Object> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<AuthError> fields = const {
    #message: _f$message,
    #error: _f$error,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthError';
  @override
  late final ClassMapperBase superMapper = AuthStateMapper.ensureInitialized();

  static AuthError _instantiate(DecodingData data) {
    return AuthError(data.dec(_f$message), error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthError>(map);
  }

  static AuthError fromJson(String json) {
    return ensureInitialized().decodeJson<AuthError>(json);
  }
}

mixin AuthErrorMappable {
  String toJson() {
    return AuthErrorMapper.ensureInitialized()
        .encodeJson<AuthError>(this as AuthError);
  }

  Map<String, dynamic> toMap() {
    return AuthErrorMapper.ensureInitialized()
        .encodeMap<AuthError>(this as AuthError);
  }

  AuthErrorCopyWith<AuthError, AuthError, AuthError> get copyWith =>
      _AuthErrorCopyWithImpl(this as AuthError, $identity, $identity);
  @override
  String toString() {
    return AuthErrorMapper.ensureInitialized()
        .stringifyValue(this as AuthError);
  }

  @override
  bool operator ==(Object other) {
    return AuthErrorMapper.ensureInitialized()
        .equalsValue(this as AuthError, other);
  }

  @override
  int get hashCode {
    return AuthErrorMapper.ensureInitialized().hashValue(this as AuthError);
  }
}

extension AuthErrorValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthError, $Out> {
  AuthErrorCopyWith<$R, AuthError, $Out> get $asAuthError =>
      $base.as((v, t, t2) => _AuthErrorCopyWithImpl(v, t, t2));
}

abstract class AuthErrorCopyWith<$R, $In extends AuthError, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message, Object? error});
  AuthErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthError, $Out>
    implements AuthErrorCopyWith<$R, AuthError, $Out> {
  _AuthErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthError> $mapper =
      AuthErrorMapper.ensureInitialized();
  @override
  $R call({String? message, Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (message != null) #message: message,
        if (error != $none) #error: error
      }));
  @override
  AuthError $make(CopyWithData data) =>
      AuthError(data.get(#message, or: $value.message),
          error: data.get(#error, or: $value.error));

  @override
  AuthErrorCopyWith<$R2, AuthError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthErrorCopyWithImpl($value, $cast, t);
}
