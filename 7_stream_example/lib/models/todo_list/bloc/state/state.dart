import 'package:stream_example/bloc/base/state.dart';
import 'package:stream_example/bloc/base/tag.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';

part 'list_states.dart';

abstract class TodoListState extends BlocState { 
  const TodoListState({super.tag});
  static const TodoListState initial = TodoListInitialState();
  static const TodoListState loading = TodoListLoadingState();
  static const TodoListState loadingError = TodoListLoadingErrorState();
  static const TodoListState emptyState = TodoListEmptyState();
}
