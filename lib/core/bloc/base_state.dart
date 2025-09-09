import 'package:dart_mappable/dart_mappable.dart';

part 'base_state.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class BaseState<T> with BaseStateMappable<T> {
  const BaseState();

  static const fromMap = BaseStateMapper.fromMap;
  static const fromJson = BaseStateMapper.fromJson;
}

@MappableClass()
class Initial extends BaseState<Never> with InitialMappable {
  const Initial();
}

@MappableClass()
class Loading extends BaseState<Never> with LoadingMappable {
  const Loading();
}

@MappableClass()
class Success<T> extends BaseState<T> with SuccessMappable<T> {
  const Success(this.data);
  final T data;
}

@MappableClass()
class Error<T> extends BaseState<T> with ErrorMappable<T> {
  const Error(this.message, {this.error});
  final String message;
  final Object? error;
}
