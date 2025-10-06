part of 'base_state.dart';

class BaseStateMapper extends ClassMapperBase<BaseState> {
  BaseStateMapper._();

  static BaseStateMapper? _instance;
  static BaseStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseStateMapper._());
      InitialMapper.ensureInitialized();
      LoadingMapper.ensureInitialized();
      SuccessMapper.ensureInitialized();
      ErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseState';
  @override
  Function get typeFactory => <T>(f) => f<BaseState<T>>();

  @override
  final MappableFields<BaseState> fields = const {};

  static BaseState<T> _instantiate<T>(DecodingData data) {
    throw MapperException.missingSubclass(
        'BaseState', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static BaseState<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseState<T>>(map);
  }

  static BaseState<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<BaseState<T>>(json);
  }
}

mixin BaseStateMappable<T> {
  String toJson();
  Map<String, dynamic> toMap();
  BaseStateCopyWith<BaseState<T>, BaseState<T>, BaseState<T>, T> get copyWith;
}

abstract class BaseStateCopyWith<$R, $In extends BaseState<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  BaseStateCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class InitialMapper extends SubClassMapperBase<Initial> {
  InitialMapper._();

  static InitialMapper? _instance;
  static InitialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InitialMapper._());
      BaseStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Initial';

  @override
  final MappableFields<Initial> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Initial';
  @override
  late final ClassMapperBase superMapper = BaseStateMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static Initial _instantiate(DecodingData data) {
    return Initial();
  }

  @override
  final Function instantiate = _instantiate;

  static Initial fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Initial>(map);
  }

  static Initial fromJson(String json) {
    return ensureInitialized().decodeJson<Initial>(json);
  }
}

mixin InitialMappable {
  String toJson() {
    return InitialMapper.ensureInitialized()
        .encodeJson<Initial>(this as Initial);
  }

  Map<String, dynamic> toMap() {
    return InitialMapper.ensureInitialized()
        .encodeMap<Initial>(this as Initial);
  }

  InitialCopyWith<Initial, Initial, Initial> get copyWith =>
      _InitialCopyWithImpl(this as Initial, $identity, $identity);
  @override
  String toString() {
    return InitialMapper.ensureInitialized().stringifyValue(this as Initial);
  }

  @override
  bool operator ==(Object other) {
    return InitialMapper.ensureInitialized()
        .equalsValue(this as Initial, other);
  }

  @override
  int get hashCode {
    return InitialMapper.ensureInitialized().hashValue(this as Initial);
  }
}

extension InitialValueCopy<$R, $Out> on ObjectCopyWith<$R, Initial, $Out> {
  InitialCopyWith<$R, Initial, $Out> get $asInitial =>
      $base.as((v, t, t2) => _InitialCopyWithImpl(v, t, t2));
}

abstract class InitialCopyWith<$R, $In extends Initial, $Out>
    implements BaseStateCopyWith<$R, $In, $Out, Never> {
  @override
  $R call();
  InitialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InitialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Initial, $Out>
    implements InitialCopyWith<$R, Initial, $Out> {
  _InitialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Initial> $mapper =
      InitialMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  Initial $make(CopyWithData data) => Initial();

  @override
  InitialCopyWith<$R2, Initial, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _InitialCopyWithImpl($value, $cast, t);
}

class LoadingMapper extends SubClassMapperBase<Loading> {
  LoadingMapper._();

  static LoadingMapper? _instance;
  static LoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoadingMapper._());
      BaseStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Loading';

  @override
  final MappableFields<Loading> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Loading';
  @override
  late final ClassMapperBase superMapper = BaseStateMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static Loading _instantiate(DecodingData data) {
    return Loading();
  }

  @override
  final Function instantiate = _instantiate;

  static Loading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Loading>(map);
  }

  static Loading fromJson(String json) {
    return ensureInitialized().decodeJson<Loading>(json);
  }
}

mixin LoadingMappable {
  String toJson() {
    return LoadingMapper.ensureInitialized()
        .encodeJson<Loading>(this as Loading);
  }

  Map<String, dynamic> toMap() {
    return LoadingMapper.ensureInitialized()
        .encodeMap<Loading>(this as Loading);
  }

  LoadingCopyWith<Loading, Loading, Loading> get copyWith =>
      _LoadingCopyWithImpl(this as Loading, $identity, $identity);
  @override
  String toString() {
    return LoadingMapper.ensureInitialized().stringifyValue(this as Loading);
  }

  @override
  bool operator ==(Object other) {
    return LoadingMapper.ensureInitialized()
        .equalsValue(this as Loading, other);
  }

  @override
  int get hashCode {
    return LoadingMapper.ensureInitialized().hashValue(this as Loading);
  }
}

extension LoadingValueCopy<$R, $Out> on ObjectCopyWith<$R, Loading, $Out> {
  LoadingCopyWith<$R, Loading, $Out> get $asLoading =>
      $base.as((v, t, t2) => _LoadingCopyWithImpl(v, t, t2));
}

abstract class LoadingCopyWith<$R, $In extends Loading, $Out>
    implements BaseStateCopyWith<$R, $In, $Out, Never> {
  @override
  $R call();
  LoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Loading, $Out>
    implements LoadingCopyWith<$R, Loading, $Out> {
  _LoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Loading> $mapper =
      LoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  Loading $make(CopyWithData data) => Loading();

  @override
  LoadingCopyWith<$R2, Loading, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LoadingCopyWithImpl($value, $cast, t);
}

class SuccessMapper extends SubClassMapperBase<Success> {
  SuccessMapper._();

  static SuccessMapper? _instance;
  static SuccessMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SuccessMapper._());
      BaseStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Success';
  @override
  Function get typeFactory => <T>(f) => f<Success<T>>();

  static dynamic _$data(Success v) => v.data;
  static dynamic _arg$data<T>(f) => f<T>();
  static const Field<Success, dynamic> _f$data =
      Field('data', _$data, arg: _arg$data);

  @override
  final MappableFields<Success> fields = const {
    #data: _f$data,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Success';
  @override
  late final ClassMapperBase superMapper = BaseStateMapper.ensureInitialized();

  static Success<T> _instantiate<T>(DecodingData data) {
    return Success(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static Success<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Success<T>>(map);
  }

  static Success<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<Success<T>>(json);
  }
}

mixin SuccessMappable<T> {
  String toJson() {
    return SuccessMapper.ensureInitialized()
        .encodeJson<Success<T>>(this as Success<T>);
  }

  Map<String, dynamic> toMap() {
    return SuccessMapper.ensureInitialized()
        .encodeMap<Success<T>>(this as Success<T>);
  }

  SuccessCopyWith<Success<T>, Success<T>, Success<T>, T> get copyWith =>
      _SuccessCopyWithImpl(this as Success<T>, $identity, $identity);
  @override
  String toString() {
    return SuccessMapper.ensureInitialized().stringifyValue(this as Success<T>);
  }

  @override
  bool operator ==(Object other) {
    return SuccessMapper.ensureInitialized()
        .equalsValue(this as Success<T>, other);
  }

  @override
  int get hashCode {
    return SuccessMapper.ensureInitialized().hashValue(this as Success<T>);
  }
}

extension SuccessValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, Success<T>, $Out> {
  SuccessCopyWith<$R, Success<T>, $Out, T> get $asSuccess =>
      $base.as((v, t, t2) => _SuccessCopyWithImpl(v, t, t2));
}

abstract class SuccessCopyWith<$R, $In extends Success<T>, $Out, T>
    implements BaseStateCopyWith<$R, $In, $Out, T> {
  @override
  $R call({T? data});
  SuccessCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SuccessCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, Success<T>, $Out>
    implements SuccessCopyWith<$R, Success<T>, $Out, T> {
  _SuccessCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Success> $mapper =
      SuccessMapper.ensureInitialized();
  @override
  $R call({T? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  Success<T> $make(CopyWithData data) =>
      Success(data.get(#data, or: $value.data));

  @override
  SuccessCopyWith<$R2, Success<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SuccessCopyWithImpl($value, $cast, t);
}

class ErrorMapper extends SubClassMapperBase<Error> {
  ErrorMapper._();

  static ErrorMapper? _instance;
  static ErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorMapper._());
      BaseStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Error';
  @override
  Function get typeFactory => <T>(f) => f<Error<T>>();

  static String _$message(Error v) => v.message;
  static const Field<Error, String> _f$message = Field('message', _$message);
  static Object? _$error(Error v) => v.error;
  static const Field<Error, Object> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<Error> fields = const {
    #message: _f$message,
    #error: _f$error,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Error';
  @override
  late final ClassMapperBase superMapper = BaseStateMapper.ensureInitialized();

  static Error<T> _instantiate<T>(DecodingData data) {
    return Error(data.dec(_f$message), error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static Error<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Error<T>>(map);
  }

  static Error<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<Error<T>>(json);
  }
}

mixin ErrorMappable<T> {
  String toJson() {
    return ErrorMapper.ensureInitialized()
        .encodeJson<Error<T>>(this as Error<T>);
  }

  Map<String, dynamic> toMap() {
    return ErrorMapper.ensureInitialized()
        .encodeMap<Error<T>>(this as Error<T>);
  }

  ErrorCopyWith<Error<T>, Error<T>, Error<T>, T> get copyWith =>
      _ErrorCopyWithImpl(this as Error<T>, $identity, $identity);
  @override
  String toString() {
    return ErrorMapper.ensureInitialized().stringifyValue(this as Error<T>);
  }

  @override
  bool operator ==(Object other) {
    return ErrorMapper.ensureInitialized().equalsValue(this as Error<T>, other);
  }

  @override
  int get hashCode {
    return ErrorMapper.ensureInitialized().hashValue(this as Error<T>);
  }
}

extension ErrorValueCopy<$R, $Out, T> on ObjectCopyWith<$R, Error<T>, $Out> {
  ErrorCopyWith<$R, Error<T>, $Out, T> get $asError =>
      $base.as((v, t, t2) => _ErrorCopyWithImpl(v, t, t2));
}

abstract class ErrorCopyWith<$R, $In extends Error<T>, $Out, T>
    implements BaseStateCopyWith<$R, $In, $Out, T> {
  @override
  $R call({String? message, Object? error});
  ErrorCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ErrorCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, Error<T>, $Out>
    implements ErrorCopyWith<$R, Error<T>, $Out, T> {
  _ErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Error> $mapper = ErrorMapper.ensureInitialized();
  @override
  $R call({String? message, Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (message != null) #message: message,
        if (error != $none) #error: error
      }));
  @override
  Error<T> $make(CopyWithData data) =>
      Error(data.get(#message, or: $value.message),
          error: data.get(#error, or: $value.error));

  @override
  ErrorCopyWith<$R2, Error<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ErrorCopyWithImpl($value, $cast, t);
}
