import 'dart:async';

import 'package:stream_example/bloc/base/bloc_handle_storage.dart';
import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/bloc/base/state.dart';
import 'package:stream_example/bloc/base/tag.dart';

abstract class Bloc<E extends BlocEvent, S extends BlocState> {
  void emit<Event extends E>(Event event);
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
  }

  @override
  late final Stream<S> out = _stateStreamController.stream.asBroadcastStream();

  @override
  S get state => _state;
  
  @override
  void emit<Event extends E>(Event event) => _mapEventToState(event);
  
  @override
  void emitState(S state) {
    _state = state;
    _stateStreamController.add(state);
  }
  
  FutureOr<void> _mapEventToState<Event extends E>(Event event) async {
    final handlers = _blocHandleStorage.getHandlersAtEvent(event);
    for (var handler in handlers) {
      await handler(event);
    }
  }
  
  @override
  void onEvent<Event extends E>(EventHandler<Event> handler, {BlocTag tag = BlocTag.global}) {
    _blocHandleStorage.addEventHandler<Event>(handler, tag);
  }

  @override
  void dispose() {
    _blocHandleStorage.dispose();
    _stateStreamController.close();
  }

  final StreamController<S> _stateStreamController = StreamController<S>();
  late final BlocHandleStorage<E> _blocHandleStorage;

  late S _state;
}
