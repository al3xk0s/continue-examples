import 'dart:async';

import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/bloc/base/tag.dart';

typedef EventHandler<E> = FutureOr<void> Function(E event);

abstract class BlocHandleStorage<E extends BlocEvent> {
  void addEventHandler<Event extends E>(EventHandler<Event> handler, [BlocTag tag = BlocTag.global]);
  List<EventHandler<E>> getHandlersAtEvent(E event);
  dispose();
}

class BlocHandleStorageImpl<E extends BlocEvent> implements BlocHandleStorage<E>{
  final _tagHandleMap = < BlocTag, Map<Type, List<EventHandler<E>>> >{};
  
  @override
  void addEventHandler<Event extends E>(EventHandler<Event> handler, [BlocTag tag = BlocTag.global]) {
    final eventHandlersMap = _tagHandleMap[tag] ?? {};
    final handlers = eventHandlersMap[Event] ?? [];
    handlers.add((E event) => handler(event as Event));
    eventHandlersMap[Event] = handlers;
    _tagHandleMap[tag] = eventHandlersMap;
  }

  @override
  List<EventHandler<E>> getHandlersAtEvent(E event) {
    final BlocTag tag = event.tag;
    final tagHandlersMap = _tagHandleMap[tag] ?? {};
    return tagHandlersMap[event.runtimeType] ?? const [];
  }

  @override
  dispose() {
    _tagHandleMap.forEach((key, value) => value.clear());
    _tagHandleMap.clear();
  }
}
