import 'dart:async';

import 'package:stream_example/bloc/base/bloc_handle_storage.dart';
import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/bloc/base/state.dart';
import 'package:stream_example/bloc/base/tag.dart';

abstract class Bloc<E extends BlocEvent, S extends BlocState>{
  void emit(E event);
  void emitState(S state);

  void onEvent<Event extends E>(EventHandler<Event> handler, {BlocTag tag = const GlobalBlocTag()});

  Stream<S> get out;

  void dispose();

  S get state;
}

abstract class BlocBase<E extends BlocEvent, S extends BlocState> implements Bloc<E, S> {
  BlocBase(S initialState, BlocHandleStorage<E> blocHandleStorage) {
    _blocHandleStorage = blocHandleStorage;
    _state = initialState;
    _eventInputController.stream.listen(_mapEventToState);
  }

  @override
  Stream<S> get out => _stateStreamController.stream.asBroadcastStream();

  @override
  S get state => _state;
  
  @override
  void emit(E event) => _eventInput.add(event);
  
  @override
  void emitState(S state) {
    _state = state;
    _stateInput.add(state);
  }
  
  FutureOr<void> _mapEventToState(E event) async {
    final handlers = _blocHandleStorage.getHandlersAtEvent(event);
    for (var handler in handlers) {
      await handler(event);
    }
  }
  
  @override
  void onEvent<Event extends E>(EventHandler<Event> handler, {BlocTag tag = const GlobalBlocTag()}) {
    _blocHandleStorage.addEventHandler<Event>(handler, tag);
  }

  @override
  void dispose() {
    _blocHandleStorage.dispose();
    _eventInputController.close();
    _stateStreamController.close();
  }

  final StreamController<E> _eventInputController = StreamController<E>();
  final StreamController<S> _stateStreamController = StreamController<S>();
  late final BlocHandleStorage<E> _blocHandleStorage;

  late S _state;

  StreamSink<E> get _eventInput => _eventInputController.sink;
  StreamSink<S> get _stateInput => _stateStreamController.sink;
}
