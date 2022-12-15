import 'dart:async';

typedef EventHandler<E> = FutureOr<void> Function(E event);

abstract class BlocHandleStorage<E> {
  void addEventHandler<Event extends E>(EventHandler<Event> handler);
  List<EventHandler<E>> getHandlersAtEvent(E event);
  dispose();
}

class BlocHandleStorageImpl<E> implements BlocHandleStorage<E>{
  final _eventTypeHandleMap = < Type, List<EventHandler<E>> >{};
  
  @override
  void addEventHandler<Event extends E>(EventHandler<Event> handler) {
    final handlers = _eventTypeHandleMap[Event] ?? [];
    handlers.add((E event) => handler(event as Event));
    _eventTypeHandleMap[Event] = handlers;
  }

  @override
  List<EventHandler<E>> getHandlersAtEvent(E event) {
    return _eventTypeHandleMap[event.runtimeType] ?? const [];
  }

  @override
  dispose() {
    _eventTypeHandleMap.forEach((key, value) => value.clear());
    _eventTypeHandleMap.clear();
  }
}