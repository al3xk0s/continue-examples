import 'dart:math';

import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';
import 'package:stream_example/models/todo/factory/todo_factory.dart';

abstract class TodoRepository {
  Stream<TodoModel> getTodos();

  Future<void> addTodo(TodoModel todo);

  Future<TodoModel?> getTodo(TodoId id);
  
  Future<TodoModel> removeTodo(TodoId id);

  Future<bool> hasTodo(TodoId id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl._([List<TodoModel>? initialData]) {
    _idTodoMap = {};

    initialData ??= const [];
    for (var todo in initialData) {
      _idTodoMap[todo.id] = todo;
    }
  }

  TodoRepositoryImpl.empty() : this._();

  TodoRepositoryImpl.fromTodos(List<Todo> todos, TodoFactory factory) 
  : this._(todos.map((t) => _mapTodo(t, factory)).toList());

  TodoRepositoryImpl.fromModels(List<TodoModel> models) : this._(models);

  late final Map<TodoId, TodoModel> _idTodoMap;
  
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
  Future<TodoModel> removeTodo(TodoId id) async {
    await _delay();
    return _idTodoMap.remove(id)!;
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

  static TodoModel _mapTodo(Todo todo, TodoFactory factory) {
    return factory.create(id: todo.id, title: todo.title, isActual: todo.isActual);
  }
}
