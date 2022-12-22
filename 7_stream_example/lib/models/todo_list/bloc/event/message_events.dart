part of 'event.dart';

class TodoListMessageEvent extends TodoListEvent {
  const TodoListMessageEvent(this.message);
  final String? message;
}

class TodoListInvalidTodoTitleEvent extends TodoListMessageEvent {
  const TodoListInvalidTodoTitleEvent(super.message);
}

class TodoListEmptyTodoTitleEvent extends TodoListMessageEvent {
  const TodoListEmptyTodoTitleEvent(super.message);
}

class TodoListChangedTitleEvent extends TodoListMessageEvent {
  const TodoListChangedTitleEvent(super.message);
}

class TodoListTodoResolvedEvent extends TodoListMessageEvent {
  TodoListTodoResolvedEvent(super.message);
}

class TodoListTodoActualizeEvent extends TodoListMessageEvent {
  TodoListTodoActualizeEvent(super.message);
}

class TodoListTodoRemovedEvent extends TodoListMessageEvent {
  TodoListTodoRemovedEvent(super.message);
}