import 'dart:async';

import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/bloc/base/tag.dart';

typedef EventHandler<E> = FutureOr<void> Function(E event);

abstract class BlocHandleStorage<E extends BlocEvent> {
  void addEventHandler<Event extends E>(EventHandler<Event> handler, [BlocTag tag = const GlobalBlocTag()]);
  List<EventHandler<E>> getHandlersAtEvent(E event);
  dispose();
}

class BlocHandleStorageImpl<E extends BlocEvent> implements BlocHandleStorage<E>{
  final _typeHandleMap = < Type, Map<BlocTag, List<EventHandler<E>>> >{};
  
  @override
  void addEventHandler<Event extends E>(EventHandler<Event> handler, [BlocTag tag = const GlobalBlocTag()]) {
    final tagHandlersMap = _typeHandleMap[Event] ?? {};
    final handlers = tagHandlersMap[tag] ?? [];
    handlers.add((E event) => handler(event as Event));
    tagHandlersMap[tag] = handlers;
    _typeHandleMap[Event] = tagHandlersMap;
  }

  @override
  List<EventHandler<E>> getHandlersAtEvent(E event) {
    final BlocTag tag = event.tag;
    final tagHandlersMap = _typeHandleMap[event.runtimeType] ?? {};
    return tagHandlersMap[tag] ?? const [];
  }

  @override
  dispose() {
    _typeHandleMap.forEach((key, value) => value.clear());
    _typeHandleMap.clear();
  }
}
