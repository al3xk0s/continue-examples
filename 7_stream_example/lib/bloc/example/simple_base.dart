import 'dart:async';

abstract class SimpleBloc<E, S> {
  Stream<E> get eventOut;
  Stream<S> get stateOut;

  void emit(E event);
  Stream<S> mapEventToState(E event);

  void dispose();
}

abstract class SimpleBlocBase<E, S> implements SimpleBloc<E, S> {
  SimpleBlocBase() {
    _eventOut.listen((event) {
      _stateStream.addStream(mapEventToState(event));
    });
  }

  @override
  Stream<E> get eventOut => _eventOut;

  @override
  Stream<S> get stateOut => _stateOut;

  @override
  void emit(E event) => _eventStream.add(event);

  @override
  void dispose() {
    _eventStream.close();
    _stateStream.close();
  }

  final StreamController<E> _eventStream = StreamController();
  final StreamController<S> _stateStream = StreamController();
  
  late final Stream<E> _eventOut = _eventStream.stream.asBroadcastStream();
  late final Stream<S> _stateOut = _stateStream.stream.asBroadcastStream();
}
