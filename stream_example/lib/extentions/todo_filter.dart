import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo_list/todo_filter/filter.dart';

extension ApplyTodoFilter on Iterable<Todo> {
  Iterable<Todo> applyFilter(TodoFilter filter) {
    return filter.exec(this);
  }
}