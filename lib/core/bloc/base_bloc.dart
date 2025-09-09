import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_to_goal/core/bloc/base_event.dart';
import 'package:note_to_goal/core/bloc/base_state.dart';

abstract class BaseBloc<T extends Object>
    extends Bloc<BaseEvent, BaseState<T>> {
  BaseBloc() : super(Initial()) {
    on<BaseEvent>((event, emit) async {
      if (event is Initialized) {
        await onInitialized(emit);
      } else if (event is Refreshed) {
        await onRefreshed(emit);
      }
    });
  }

  Future<void> onInitialized(Emitter<BaseState<T>> emit) async {}

  Future<void> onRefreshed(Emitter<BaseState<T>> emit) async {}

  void emitLoading(Emitter<BaseState<T>> emit) {
    if (state is! Loading) emit(Loading());
  }

  void emitSuccess(Emitter<BaseState<T>> emit, T data) => emit(Success(data));

  void emitError(Emitter<BaseState<T>> emit, String message, {Object? error}) =>
      emit(Error(message, error: error));
}
