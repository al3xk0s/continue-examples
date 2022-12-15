import 'package:stream_example/models/todo/todo.dart';
import 'package:stream_example/models/todo_repository.dart';

abstract class TodoList {
  Future<List<Todo>> getTodos();
  Future<Todo> getTodo(TodoId id);
  Future<void> removeTodo(TodoId id);
}

class TodoListImpl implements TodoList {
  TodoListImpl(this.repository);

  final TodoRepository repository;
}
