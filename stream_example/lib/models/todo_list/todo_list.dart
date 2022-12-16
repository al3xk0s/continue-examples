import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';
import 'package:stream_example/models/todo/factory/todo_factory.dart';
import 'package:stream_example/models/todo_repository.dart';

abstract class TodoList {
  Stream<Todo> getTodos();
  Future<Todo> getTodo(TodoId id);
  Future<void> removeTodo(TodoId id);
  Future<Todo> addTodo(String title);

  Future<Todo> renameTodo(TodoId id, String newTitle);
  Future<Todo> switchTodoStatus(TodoId id);
}

class TodoListImpl implements TodoList {
  TodoListImpl(TodoRepository repository, TodoFactory todoFactory) {
    _repository = repository;
    _todoFactory = todoFactory;
  }

  late final TodoRepository _repository;
  late final TodoFactory _todoFactory;
  
  @override
  Future<Todo> addTodo(String title) async {
    final TodoModel todoModel = _todoFactory.create(title: title, isActual: true);
    await _repository.addTodo(todoModel);
    return todoModel;
  }
  
  @override
  Future<Todo> getTodo(TodoId id) async {
    _validateTodoId(id);
    final Todo? todo = await _repository.getTodo(id);
    return todo!;
  }
  
  @override
  Stream<Todo> getTodos() {
    return _repository.getTodos();
  }
  
  @override
  Future<void> removeTodo(TodoId id) async {
    await _validateTodoId(id);
    return _repository.removeTodo(id);
  }
  
  @override
  Future<Todo> renameTodo(TodoId id, String newTitle) async {
    await _validateTodoId(id);
    final TodoModel todo = (await _repository.getTodo(id))!;
    todo.rename(newTitle);
    return todo;
  }
  
  @override
  Future<Todo> switchTodoStatus(TodoId id) async {
    await _validateTodoId(id);
    final TodoModel todo = (await _repository.getTodo(id))!;
    todo.switchStatus();
    return todo;
  }

    Future<void> _validateTodoId(TodoId id) async {
    if(await _repository.hasTodo(id)) throw Exception('Задача с id $id отсутствует');
  }
}
