import 'package:stream_example/models/todo/abstract/todo.dart';

part 'impl.dart';

abstract class TodoFilter {
  Iterable<Todo> exec(Iterable<Todo> todos);
  String get description;

  static const TodoFilter sorting = StatusSortingFilter();
  static const TodoFilter onlyActual = OnlyActualFilter();
  static const TodoFilter onlyResolved = OnlyResolvedFilter();
}

abstract class _WhereFilter implements TodoFilter {
  const _WhereFilter({required this.isMatch});

  final bool Function(Todo todo) isMatch;

  @override
  Iterable<Todo> exec(Iterable<Todo> todos) {
    return todos.where(isMatch);
  }
}

bool _isActual(Todo t) => t.isActual;
bool _isNotActual(Todo t) => !_isActual(t);