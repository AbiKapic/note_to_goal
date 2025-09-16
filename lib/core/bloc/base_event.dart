import 'package:dart_mappable/dart_mappable.dart';

part 'base_event.mapper.dart';

@MappableClass(discriminatorKey: 'type')
abstract class BaseEvent with BaseEventMappable {
  const BaseEvent();

  static const fromMap = BaseEventMapper.fromMap;
  static const fromJson = BaseEventMapper.fromJson;
}

@MappableClass()
class Initialized extends BaseEvent with InitializedMappable {
  const Initialized();
}

@MappableClass()
class Refreshed extends BaseEvent with RefreshedMappable {
  const Refreshed();
}
