part of 'event.dart';

class _TodoListHasTodoEvent extends _TodoListIdEvent {
  _TodoListHasTodoEvent(this.todo) : super(todo.id);
  final Todo todo;
}

class TodoEditTitleEvent extends _TodoListHasTodoEvent {
  TodoEditTitleEvent(super.todo, this.newTitle);
  final String? newTitle;
}

class TodoSwitchStatusEvent extends _TodoListHasTodoEvent {
  TodoSwitchStatusEvent(super.todo);
}

