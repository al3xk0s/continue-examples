import 'package:stream_example/bloc/base/bloc.dart';
import 'package:stream_example/bloc/base/bloc_handle_storage.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/models/todo_list/bloc/message_generator.dart';
import 'package:stream_example/models/todo_list/bloc/state/state.dart';
import 'package:stream_example/models/todo_list/todo_list.dart';

class TodoListBloc extends BlocBase<TodoListEvent, TodoListState> {
  TodoListBloc(this.todoList) : super(
    const TodoListInitialState(),
    BlocHandleStorageImpl()
  ) {

    onEvent<TodoListGetDataEvent>(_onGetData);
    onEvent<TodoListCreateTodoEvent>(_onCreateTodo);
    onEvent<TodoEditTitleEvent>(_onEditTitle);
    onEvent<TodoSwitchStatusEvent>(_onSwitchTodoStatus);
    onEvent<TodoListRemoveTodoEvent>(_onRemoveTodo);
  }

  final TodoList todoList;

  Future<void> _onGetData(TodoListGetDataEvent event) async {
    try {
      final List<Todo> todos = await todoList.getTodos().toList();
      final List<Todo> sorted = _getSortedTodo(todos);      

      sorted.isEmpty ? 
        emitState(TodoListState.empty) :
        emitState(TodoListSuccessLoadedState(sorted));
    } catch (e) {
      emitState(TodoListState.loadingError);
    }
  }

  Future<void> _onCreateTodo(TodoListCreateTodoEvent event) async {
    if(!_validateTitle(event.title)) return;

    await todoList.addTodo(event.title!);

    emit(TodoListChangedTitleEvent(getChangeTitleMessage(event.title!)));
    emit(TodoListEvent.getData);
  }

  Future<void> _onEditTitle(TodoEditTitleEvent event) async {
    final Todo old = event.todo;

    if(old.title == event.newTitle) return;
    if(!_validateTitle(event.newTitle)) return;
    
    await todoList.editTodo(old.id, event.newTitle!, old.isActual);

    emit(TodoListChangedTitleEvent(getChangeTitleMessage(event.newTitle!)));
    emit(TodoListEvent.getData);
  }

  Future<void> _onSwitchTodoStatus(TodoSwitchStatusEvent event) async {
    final Todo old = event.todo;
    await todoList.editTodo(old.id, old.title, !old.isActual);

    !old.isActual ? 
      emit(TodoListTodoResolvedEvent(getResolveTodoMessage(''))) :
      emit(TodoListTodoActualizeEvent(getActualizeTodoMessage('')));

    emit(TodoListEvent.getData);
  }

  Future<void> _onRemoveTodo(TodoListRemoveTodoEvent event) async {
    final Todo todo = await todoList.removeTodo(event.id);
    emit(TodoListTodoRemovedEvent(getRemoveTodoMessage(todo.title)));
    emit(TodoListEvent.getData);
  }

  bool _validateTitle(String? title) {
    if(title != null && title.isNotEmpty) return true;

    if(title == null) {
      emit(TodoListEmptyTodoTitleEvent(getEmptyTitleMessage('')));
    } else if (title.isEmpty) {
      emit(TodoListInvalidTodoTitleEvent(getInvalidTitleMessage('')));
    }

    return false;
  }

  List<Todo> _getSortedTodo(List<Todo> todo) {
    final List<Todo> result = [];

    result.addAll(todo.where((t) => t.isActual));
    result.addAll(todo.where((t) => !t.isActual));

    return result;
  }
} 

