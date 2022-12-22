part of 'state.dart';

class TodoListInitialState extends TodoListState {
  const TodoListInitialState() : super(tag: BlocTag.global);
}

class TodoListLoadingState extends TodoListState {
  const TodoListLoadingState() : super(tag: BlocTag.global);
}

class TodoListSuccessLoadedState extends TodoListState {
  const TodoListSuccessLoadedState(this.todos);
  final List<Todo> todos;
}

class TodoListEmptyState extends TodoListState {
  const TodoListEmptyState();
}

class TodoListLoadingErrorState extends TodoListState {
  const TodoListLoadingErrorState();
}

