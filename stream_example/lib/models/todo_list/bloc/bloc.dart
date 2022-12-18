import 'dart:async';

import 'package:stream_example/bloc/base/bloc.dart';
import 'package:stream_example/bloc/base/bloc_handle_storage.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/models/todo_list/bloc/message_generator.dart';
import 'package:stream_example/models/todo_list/bloc/state/state.dart';
import 'package:stream_example/models/todo_list/todo_filter/filter.dart';
import 'package:stream_example/models/todo_list/todo_list.dart';

class TodoListBloc extends BlocBase<TodoListEvent, TodoListState> {
  TodoListBloc(this.todoList) : super(
    TodoListState.initial,
    BlocHandleStorageImpl()
  ) {

    onEvent<TodoListGetDataEvent>(_onGetData);
    onEvent<TodoListNextFilterEvent>(_onNextFilterEvent);
    onEvent<TodoListCreateTodoEvent>(_onCreateTodo);
    onEvent<TodoEditTitleEvent>(_onEditTitle);
    onEvent<TodoSwitchStatusEvent>(_onSwitchTodoStatus);
    onEvent<TodoListRemoveTodoEvent>(_onRemoveTodo);
  }

  static const List<TodoFilter> _filters = [
    TodoFilter.sorting,
    TodoFilter.onlyActual,
    TodoFilter.onlyResolved, 
  ];

  final TodoList todoList;
  TodoFilter get filter => _actualFilter;
  TodoFilter get nextFilter => _getNextFilter();

  TodoFilter _actualFilter = _filters.first;

  Future<void> _onGetData(TodoListGetDataEvent event) async {
    try {
      final List<Todo> todos = await todoList.getTodos().toList();
      final List<Todo> selectedTodos = _actualFilter.exec(todos).toList();      

      selectedTodos.isEmpty ? 
        emitState(TodoListState.emptyState) :
        emitState(TodoListSuccessLoadedState(selectedTodos));
    } catch (e) {
      emitState(TodoListState.loadingError);
    }
  }

  FutureOr<void> _onNextFilterEvent(TodoListNextFilterEvent event) {
    _actualFilter = nextFilter;
    emit(TodoListEvent.getData);
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

  TodoFilter _getNextFilter() {
    final int index = _filters.indexOf(filter);
    if(index == -1) throw Exception('Illegal argument');

    return _filters[(index + 1) % _filters.length];
  }
} 

