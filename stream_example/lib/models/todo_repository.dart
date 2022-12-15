import 'dart:math';

import 'package:stream_example/models/todo/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<void> addTodo(Todo todo);

  Future<Todo?> getTodo(TodoId id);
  
  Future<void> removeTodo(TodoId id);

  Future<bool> hasTodo(TodoId id);
}

class TodoRepositoryImpl implements TodoRepository {
  final _idTodoMap = <TodoId, Todo>{};
  
  @override
  Future<void> addTodo(Todo todo) async {
    await _delay();

    if(_idTodoMap.containsKey(todo.id)) {
      throw Exception('Невозможно добавить todo с id ${todo.id}');
    }

    _idTodoMap[todo.id] = todo;
  }
  
  @override
  Future<List<Todo>> getTodos() async {
    await _delay();
    return _idTodoMap.values.toList();
  }
  
  @override
  Future<bool> hasTodo(TodoId id) async {
    await _delay();
    return _idTodoMap.containsKey(id);
  }
  
  @override
  Future<void> removeTodo(TodoId id) async {
    if(!(await hasTodo(id))) throw Exception('Удаляемая задача с id $id не найдена');
    _idTodoMap.remove(id);
  }

  final Random _gen = Random();

  Future<void> _delay() {
    final Duration duration = Duration(seconds: _gen.nextInt(2), microseconds: _gen.nextInt(499));
    return Future.delayed(duration);
  }
  
  @override
  Future<Todo?> getTodo(TodoId id) async {
    await _delay();
    return _idTodoMap[id];
  }
}
