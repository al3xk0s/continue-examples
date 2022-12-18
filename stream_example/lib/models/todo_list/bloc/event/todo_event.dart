part of 'event.dart';

class TodoEditTitleEvent extends _TodoListHasTodoEvent {
  TodoEditTitleEvent(super.todo, this.newTitle);
  final String? newTitle;
}

class TodoSwitchStatusEvent extends _TodoListHasTodoEvent {
  TodoSwitchStatusEvent(super.todo);
}

