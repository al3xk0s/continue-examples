part of 'event.dart';

class TodoListGetDataEvent extends TodoListEvent {
  const TodoListGetDataEvent();
}

class TodoListNextFilterEvent extends TodoListEvent {
  const TodoListNextFilterEvent();
}

class TodoListCreateTodoEvent extends TodoListEvent {
  const TodoListCreateTodoEvent(this.title);
  final String? title;
}

class TodoListRemoveTodoEvent extends _TodoListIdEvent {
  const TodoListRemoveTodoEvent(super.id);
}