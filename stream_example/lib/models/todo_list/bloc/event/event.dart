import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';

part 'list_events.dart';
part 'todo_event.dart';
part 'message_events.dart';

abstract class TodoListEvent extends BlocEvent { 
  const TodoListEvent({super.tag});

  static const TodoListEvent getData = TodoListGetDataEvent();
}

class _TodoListIdEvent extends TodoListEvent {
  const _TodoListIdEvent(this.id);
  final TodoId id;
}

class _TodoListHasTodoEvent extends _TodoListIdEvent {
  _TodoListHasTodoEvent(this.todo) : super(todo.id);
  final Todo todo;
}

class TodoListMessageEvent extends TodoListEvent {
  const TodoListMessageEvent(this.message);
  final String? message;
}
