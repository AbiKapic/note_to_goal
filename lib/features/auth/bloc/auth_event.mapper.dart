part of 'auth_event.dart';

class AuthEventMapper extends SubClassMapperBase<AuthEvent> {
  AuthEventMapper._();

  static AuthEventMapper? _instance;
  static AuthEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthEventMapper._());
      BaseEventMapper.ensureInitialized().addSubMapper(_instance!);
      AuthLoginRequestedMapper.ensureInitialized();
      AuthLogoutRequestedMapper.ensureInitialized();
      AuthSessionCheckRequestedMapper.ensureInitialized();
      AuthUserDataRequestedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthEvent';

  @override
  final MappableFields<AuthEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthEvent';
  @override
  late final ClassMapperBase superMapper = BaseEventMapper.ensureInitialized();

  static AuthEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'AuthEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthEvent>(map);
  }

  static AuthEvent fromJson(String json) {
    return ensureInitialized().decodeJson<AuthEvent>(json);
  }
}

mixin AuthEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthEventCopyWith<AuthEvent, AuthEvent, AuthEvent> get copyWith;
}

abstract class AuthEventCopyWith<$R, $In extends AuthEvent, $Out>
    implements BaseEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthLoginRequestedMapper extends SubClassMapperBase<AuthLoginRequested> {
  AuthLoginRequestedMapper._();

  static AuthLoginRequestedMapper? _instance;
  static AuthLoginRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthLoginRequestedMapper._());
      AuthEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthLoginRequested';

  static String _$email(AuthLoginRequested v) => v.email;
  static const Field<AuthLoginRequested, String> _f$email =
      Field('email', _$email);
  static String _$password(AuthLoginRequested v) => v.password;
  static const Field<AuthLoginRequested, String> _f$password =
      Field('password', _$password);

  @override
  final MappableFields<AuthLoginRequested> fields = const {
    #email: _f$email,
    #password: _f$password,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthLoginRequested';
  @override
  late final ClassMapperBase superMapper = AuthEventMapper.ensureInitialized();

  static AuthLoginRequested _instantiate(DecodingData data) {
    return AuthLoginRequested(
        email: data.dec(_f$email), password: data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthLoginRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthLoginRequested>(map);
  }

  static AuthLoginRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthLoginRequested>(json);
  }
}

mixin AuthLoginRequestedMappable {
  String toJson() {
    return AuthLoginRequestedMapper.ensureInitialized()
        .encodeJson<AuthLoginRequested>(this as AuthLoginRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthLoginRequestedMapper.ensureInitialized()
        .encodeMap<AuthLoginRequested>(this as AuthLoginRequested);
  }

  AuthLoginRequestedCopyWith<AuthLoginRequested, AuthLoginRequested,
          AuthLoginRequested>
      get copyWith => _AuthLoginRequestedCopyWithImpl(
          this as AuthLoginRequested, $identity, $identity);
  @override
  String toString() {
    return AuthLoginRequestedMapper.ensureInitialized()
        .stringifyValue(this as AuthLoginRequested);
  }

  @override
  bool operator ==(Object other) {
    return AuthLoginRequestedMapper.ensureInitialized()
        .equalsValue(this as AuthLoginRequested, other);
  }

  @override
  int get hashCode {
    return AuthLoginRequestedMapper.ensureInitialized()
        .hashValue(this as AuthLoginRequested);
  }
}

extension AuthLoginRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthLoginRequested, $Out> {
  AuthLoginRequestedCopyWith<$R, AuthLoginRequested, $Out>
      get $asAuthLoginRequested =>
          $base.as((v, t, t2) => _AuthLoginRequestedCopyWithImpl(v, t, t2));
}

abstract class AuthLoginRequestedCopyWith<$R, $In extends AuthLoginRequested,
    $Out> implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? email, String? password});
  AuthLoginRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthLoginRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthLoginRequested, $Out>
    implements AuthLoginRequestedCopyWith<$R, AuthLoginRequested, $Out> {
  _AuthLoginRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthLoginRequested> $mapper =
      AuthLoginRequestedMapper.ensureInitialized();
  @override
  $R call({String? email, String? password}) => $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (password != null) #password: password
      }));
  @override
  AuthLoginRequested $make(CopyWithData data) => AuthLoginRequested(
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password));

  @override
  AuthLoginRequestedCopyWith<$R2, AuthLoginRequested, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthLoginRequestedCopyWithImpl($value, $cast, t);
}

class AuthLogoutRequestedMapper
    extends SubClassMapperBase<AuthLogoutRequested> {
  AuthLogoutRequestedMapper._();

  static AuthLogoutRequestedMapper? _instance;
  static AuthLogoutRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthLogoutRequestedMapper._());
      AuthEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthLogoutRequested';

  @override
  final MappableFields<AuthLogoutRequested> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthLogoutRequested';
  @override
  late final ClassMapperBase superMapper = AuthEventMapper.ensureInitialized();

  static AuthLogoutRequested _instantiate(DecodingData data) {
    return AuthLogoutRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthLogoutRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthLogoutRequested>(map);
  }

  static AuthLogoutRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthLogoutRequested>(json);
  }
}

mixin AuthLogoutRequestedMappable {
  String toJson() {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .encodeJson<AuthLogoutRequested>(this as AuthLogoutRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .encodeMap<AuthLogoutRequested>(this as AuthLogoutRequested);
  }

  AuthLogoutRequestedCopyWith<AuthLogoutRequested, AuthLogoutRequested,
          AuthLogoutRequested>
      get copyWith => _AuthLogoutRequestedCopyWithImpl(
          this as AuthLogoutRequested, $identity, $identity);
  @override
  String toString() {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .stringifyValue(this as AuthLogoutRequested);
  }

  @override
  bool operator ==(Object other) {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .equalsValue(this as AuthLogoutRequested, other);
  }

  @override
  int get hashCode {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .hashValue(this as AuthLogoutRequested);
  }
}

extension AuthLogoutRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthLogoutRequested, $Out> {
  AuthLogoutRequestedCopyWith<$R, AuthLogoutRequested, $Out>
      get $asAuthLogoutRequested =>
          $base.as((v, t, t2) => _AuthLogoutRequestedCopyWithImpl(v, t, t2));
}

abstract class AuthLogoutRequestedCopyWith<$R, $In extends AuthLogoutRequested,
    $Out> implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthLogoutRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthLogoutRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthLogoutRequested, $Out>
    implements AuthLogoutRequestedCopyWith<$R, AuthLogoutRequested, $Out> {
  _AuthLogoutRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthLogoutRequested> $mapper =
      AuthLogoutRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthLogoutRequested $make(CopyWithData data) => AuthLogoutRequested();

  @override
  AuthLogoutRequestedCopyWith<$R2, AuthLogoutRequested, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthLogoutRequestedCopyWithImpl($value, $cast, t);
}

class AuthSessionCheckRequestedMapper
    extends SubClassMapperBase<AuthSessionCheckRequested> {
  AuthSessionCheckRequestedMapper._();

  static AuthSessionCheckRequestedMapper? _instance;
  static AuthSessionCheckRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = AuthSessionCheckRequestedMapper._());
      AuthEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthSessionCheckRequested';

  @override
  final MappableFields<AuthSessionCheckRequested> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthSessionCheckRequested';
  @override
  late final ClassMapperBase superMapper = AuthEventMapper.ensureInitialized();

  static AuthSessionCheckRequested _instantiate(DecodingData data) {
    return AuthSessionCheckRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthSessionCheckRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthSessionCheckRequested>(map);
  }

  static AuthSessionCheckRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthSessionCheckRequested>(json);
  }
}

mixin AuthSessionCheckRequestedMappable {
  String toJson() {
    return AuthSessionCheckRequestedMapper.ensureInitialized()
        .encodeJson<AuthSessionCheckRequested>(
            this as AuthSessionCheckRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthSessionCheckRequestedMapper.ensureInitialized()
        .encodeMap<AuthSessionCheckRequested>(
            this as AuthSessionCheckRequested);
  }

  AuthSessionCheckRequestedCopyWith<AuthSessionCheckRequested,
          AuthSessionCheckRequested, AuthSessionCheckRequested>
      get copyWith => _AuthSessionCheckRequestedCopyWithImpl(
          this as AuthSessionCheckRequested, $identity, $identity);
  @override
  String toString() {
    return AuthSessionCheckRequestedMapper.ensureInitialized()
        .stringifyValue(this as AuthSessionCheckRequested);
  }

  @override
  bool operator ==(Object other) {
    return AuthSessionCheckRequestedMapper.ensureInitialized()
        .equalsValue(this as AuthSessionCheckRequested, other);
  }

  @override
  int get hashCode {
    return AuthSessionCheckRequestedMapper.ensureInitialized()
        .hashValue(this as AuthSessionCheckRequested);
  }
}

extension AuthSessionCheckRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthSessionCheckRequested, $Out> {
  AuthSessionCheckRequestedCopyWith<$R, AuthSessionCheckRequested, $Out>
      get $asAuthSessionCheckRequested => $base
          .as((v, t, t2) => _AuthSessionCheckRequestedCopyWithImpl(v, t, t2));
}

abstract class AuthSessionCheckRequestedCopyWith<
    $R,
    $In extends AuthSessionCheckRequested,
    $Out> implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthSessionCheckRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthSessionCheckRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthSessionCheckRequested, $Out>
    implements
        AuthSessionCheckRequestedCopyWith<$R, AuthSessionCheckRequested, $Out> {
  _AuthSessionCheckRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthSessionCheckRequested> $mapper =
      AuthSessionCheckRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthSessionCheckRequested $make(CopyWithData data) =>
      AuthSessionCheckRequested();

  @override
  AuthSessionCheckRequestedCopyWith<$R2, AuthSessionCheckRequested, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthSessionCheckRequestedCopyWithImpl($value, $cast, t);
}

class AuthUserDataRequestedMapper
    extends SubClassMapperBase<AuthUserDataRequested> {
  AuthUserDataRequestedMapper._();

  static AuthUserDataRequestedMapper? _instance;
  static AuthUserDataRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserDataRequestedMapper._());
      AuthEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUserDataRequested';

  @override
  final MappableFields<AuthUserDataRequested> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthUserDataRequested';
  @override
  late final ClassMapperBase superMapper = AuthEventMapper.ensureInitialized();

  static AuthUserDataRequested _instantiate(DecodingData data) {
    return AuthUserDataRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUserDataRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUserDataRequested>(map);
  }

  static AuthUserDataRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUserDataRequested>(json);
  }
}

mixin AuthUserDataRequestedMappable {
  String toJson() {
    return AuthUserDataRequestedMapper.ensureInitialized()
        .encodeJson<AuthUserDataRequested>(this as AuthUserDataRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthUserDataRequestedMapper.ensureInitialized()
        .encodeMap<AuthUserDataRequested>(this as AuthUserDataRequested);
  }

  AuthUserDataRequestedCopyWith<AuthUserDataRequested, AuthUserDataRequested,
          AuthUserDataRequested>
      get copyWith => _AuthUserDataRequestedCopyWithImpl(
          this as AuthUserDataRequested, $identity, $identity);
  @override
  String toString() {
    return AuthUserDataRequestedMapper.ensureInitialized()
        .stringifyValue(this as AuthUserDataRequested);
  }

  @override
  bool operator ==(Object other) {
    return AuthUserDataRequestedMapper.ensureInitialized()
        .equalsValue(this as AuthUserDataRequested, other);
  }

  @override
  int get hashCode {
    return AuthUserDataRequestedMapper.ensureInitialized()
        .hashValue(this as AuthUserDataRequested);
  }
}

extension AuthUserDataRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUserDataRequested, $Out> {
  AuthUserDataRequestedCopyWith<$R, AuthUserDataRequested, $Out>
      get $asAuthUserDataRequested =>
          $base.as((v, t, t2) => _AuthUserDataRequestedCopyWithImpl(v, t, t2));
}

abstract class AuthUserDataRequestedCopyWith<
    $R,
    $In extends AuthUserDataRequested,
    $Out> implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthUserDataRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthUserDataRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUserDataRequested, $Out>
    implements AuthUserDataRequestedCopyWith<$R, AuthUserDataRequested, $Out> {
  _AuthUserDataRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUserDataRequested> $mapper =
      AuthUserDataRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthUserDataRequested $make(CopyWithData data) => AuthUserDataRequested();

  @override
  AuthUserDataRequestedCopyWith<$R2, AuthUserDataRequested, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthUserDataRequestedCopyWithImpl($value, $cast, t);
}
