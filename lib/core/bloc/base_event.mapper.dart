part of 'base_event.dart';

class BaseEventMapper extends ClassMapperBase<BaseEvent> {
  BaseEventMapper._();

  static BaseEventMapper? _instance;
  static BaseEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseEventMapper._());
      InitializedMapper.ensureInitialized();
      RefreshedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseEvent';

  @override
  final MappableFields<BaseEvent> fields = const {};

  static BaseEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'BaseEvent', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static BaseEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseEvent>(map);
  }

  static BaseEvent fromJson(String json) {
    return ensureInitialized().decodeJson<BaseEvent>(json);
  }
}

mixin BaseEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BaseEventCopyWith<BaseEvent, BaseEvent, BaseEvent> get copyWith;
}

abstract class BaseEventCopyWith<$R, $In extends BaseEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  BaseEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class InitializedMapper extends SubClassMapperBase<Initialized> {
  InitializedMapper._();

  static InitializedMapper? _instance;
  static InitializedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InitializedMapper._());
      BaseEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Initialized';

  @override
  final MappableFields<Initialized> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Initialized';
  @override
  late final ClassMapperBase superMapper = BaseEventMapper.ensureInitialized();

  static Initialized _instantiate(DecodingData data) {
    return Initialized();
  }

  @override
  final Function instantiate = _instantiate;

  static Initialized fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Initialized>(map);
  }

  static Initialized fromJson(String json) {
    return ensureInitialized().decodeJson<Initialized>(json);
  }
}

mixin InitializedMappable {
  String toJson() {
    return InitializedMapper.ensureInitialized()
        .encodeJson<Initialized>(this as Initialized);
  }

  Map<String, dynamic> toMap() {
    return InitializedMapper.ensureInitialized()
        .encodeMap<Initialized>(this as Initialized);
  }

  InitializedCopyWith<Initialized, Initialized, Initialized> get copyWith =>
      _InitializedCopyWithImpl(this as Initialized, $identity, $identity);
  @override
  String toString() {
    return InitializedMapper.ensureInitialized()
        .stringifyValue(this as Initialized);
  }

  @override
  bool operator ==(Object other) {
    return InitializedMapper.ensureInitialized()
        .equalsValue(this as Initialized, other);
  }

  @override
  int get hashCode {
    return InitializedMapper.ensureInitialized().hashValue(this as Initialized);
  }
}

extension InitializedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Initialized, $Out> {
  InitializedCopyWith<$R, Initialized, $Out> get $asInitialized =>
      $base.as((v, t, t2) => _InitializedCopyWithImpl(v, t, t2));
}

abstract class InitializedCopyWith<$R, $In extends Initialized, $Out>
    implements BaseEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  InitializedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InitializedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Initialized, $Out>
    implements InitializedCopyWith<$R, Initialized, $Out> {
  _InitializedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Initialized> $mapper =
      InitializedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  Initialized $make(CopyWithData data) => Initialized();

  @override
  InitializedCopyWith<$R2, Initialized, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _InitializedCopyWithImpl($value, $cast, t);
}

class RefreshedMapper extends SubClassMapperBase<Refreshed> {
  RefreshedMapper._();

  static RefreshedMapper? _instance;
  static RefreshedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RefreshedMapper._());
      BaseEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'Refreshed';

  @override
  final MappableFields<Refreshed> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Refreshed';
  @override
  late final ClassMapperBase superMapper = BaseEventMapper.ensureInitialized();

  static Refreshed _instantiate(DecodingData data) {
    return Refreshed();
  }

  @override
  final Function instantiate = _instantiate;

  static Refreshed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Refreshed>(map);
  }

  static Refreshed fromJson(String json) {
    return ensureInitialized().decodeJson<Refreshed>(json);
  }
}

mixin RefreshedMappable {
  String toJson() {
    return RefreshedMapper.ensureInitialized()
        .encodeJson<Refreshed>(this as Refreshed);
  }

  Map<String, dynamic> toMap() {
    return RefreshedMapper.ensureInitialized()
        .encodeMap<Refreshed>(this as Refreshed);
  }

  RefreshedCopyWith<Refreshed, Refreshed, Refreshed> get copyWith =>
      _RefreshedCopyWithImpl(this as Refreshed, $identity, $identity);
  @override
  String toString() {
    return RefreshedMapper.ensureInitialized()
        .stringifyValue(this as Refreshed);
  }

  @override
  bool operator ==(Object other) {
    return RefreshedMapper.ensureInitialized()
        .equalsValue(this as Refreshed, other);
  }

  @override
  int get hashCode {
    return RefreshedMapper.ensureInitialized().hashValue(this as Refreshed);
  }
}

extension RefreshedValueCopy<$R, $Out> on ObjectCopyWith<$R, Refreshed, $Out> {
  RefreshedCopyWith<$R, Refreshed, $Out> get $asRefreshed =>
      $base.as((v, t, t2) => _RefreshedCopyWithImpl(v, t, t2));
}

abstract class RefreshedCopyWith<$R, $In extends Refreshed, $Out>
    implements BaseEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  RefreshedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RefreshedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Refreshed, $Out>
    implements RefreshedCopyWith<$R, Refreshed, $Out> {
  _RefreshedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Refreshed> $mapper =
      RefreshedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  Refreshed $make(CopyWithData data) => Refreshed();

  @override
  RefreshedCopyWith<$R2, Refreshed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RefreshedCopyWithImpl($value, $cast, t);
}
