import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';
import 'package:stream_example/models/todo/factory/todo_factory.dart';
import 'package:stream_example/models/todo_list/repository/todo_repository.dart';

abstract class TodoList {
  Stream<Todo> getTodos();
  Future<Todo> getTodo(TodoId id);
  Future<Todo> removeTodo(TodoId id);
  Future<Todo> addTodo(String title);

  Future<Todo> editTodo(TodoId id, String newTitle, bool newIsActual);
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
    final TodoModel todoModel = _todoFactory.create(
      id: _todoFactory.createId(),
      title: title, 
      isActual: true,
    );
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
  Future<Todo> removeTodo(TodoId id) async {
    await _validateTodoId(id);
    return _repository.removeTodo(id);
  }
  
  @override
  Future<Todo> editTodo(TodoId id, String newTitle, bool newIsActual) async {
    await _validateTodoId(id);
    final TodoModel todo = (await _repository.getTodo(id))!;
    todo.edit(newTitle, newIsActual);
    return todo;
  }

    Future<void> _validateTodoId(TodoId id) async {
    if(!(await _repository.hasTodo(id))) throw Exception('Задача с id $id отсутствует');
  }
}
