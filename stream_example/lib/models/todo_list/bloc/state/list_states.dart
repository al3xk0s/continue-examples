part of 'state.dart';

class TodoListInitialState extends TodoListState {
  const TodoListInitialState() : super(tag: BlocTag.global);
}

class TodoListLoadingState extends TodoListState {
  const TodoListLoadingState() : super(tag: BlocTag.global);
}

abstract class HasFilterState extends TodoListState {
  const HasFilterState({required this.filter});
  final TodoFilter filter;
}

class TodoListSuccessLoadedState extends HasFilterState {
  const TodoListSuccessLoadedState(this.todos, {required super.filter});
  final List<Todo> todos;
}

class TodoListEmptyState extends HasFilterState {
  const TodoListEmptyState({required super.filter});
}

class TodoListLoadingErrorState extends TodoListState {
  const TodoListLoadingErrorState();
}
