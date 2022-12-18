part of 'event.dart';

abstract class HasFilterEvent extends TodoListEvent {
  const HasFilterEvent(this.filter);
  final TodoFilter filter;
}

class TodoListGetDataEvent extends HasFilterEvent {
  const TodoListGetDataEvent(super.filter);
}

class TodoListNextFilterEvent extends HasFilterEvent {
  const TodoListNextFilterEvent(super.filter);
}

class TodoListCreateTodoEvent extends TodoListEvent {
  const TodoListCreateTodoEvent(this.title);
  final String? title;
}

class TodoListRemoveTodoEvent extends _TodoListIdEvent {
  const TodoListRemoveTodoEvent(super.id);
}