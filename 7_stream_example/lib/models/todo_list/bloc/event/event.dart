import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';

part 'list_events.dart';
part 'todo_event.dart';
part 'message_events.dart';

abstract class TodoListEvent extends BlocEvent { 
  const TodoListEvent({super.tag});

  static const getData = TodoListGetDataEvent();
  static const nextFilter = TodoListNextFilterEvent();
}
