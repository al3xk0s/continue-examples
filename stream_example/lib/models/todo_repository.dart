import 'dart:math';

import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';

abstract class TodoRepository {
  Stream<TodoModel> getTodos();

  Future<void> addTodo(TodoModel todo);

  Future<TodoModel?> getTodo(TodoId id);
  
  Future<void> removeTodo(TodoId id);

  Future<bool> hasTodo(TodoId id);
}

class TodoRepositoryImpl implements TodoRepository {
  final _idTodoMap = <TodoId, TodoModel>{};
  
  @override
  Future<void> addTodo(TodoModel todo) async {
    await _delay();

    if(_idTodoMap.containsKey(todo.id)) {
      throw Exception('Невозможно добавить todo с id ${todo.id}');
    }

    _idTodoMap[todo.id] = todo;
  }
  
  @override
  Stream<TodoModel> getTodos() async* {
    for(final TodoId id in _idTodoMap.keys) {
      yield (await getTodo(id))!;
    }
  }
  
  @override
  Future<bool> hasTodo(TodoId id) async {
    await _delay();
    return _idTodoMap.containsKey(id);
  }
  
  @override
  Future<void> removeTodo(TodoId id) async {
    await _delay();
    _idTodoMap.remove(id);
  }

  final Random _gen = Random();

  Future<void> _delay() {
    final Duration duration = Duration(microseconds: _gen.nextInt(499));
    return Future.delayed(duration);
  }
  
  @override
  Future<TodoModel?> getTodo(TodoId id) async {
    await _delay();
    return _idTodoMap[id];
  }
}
