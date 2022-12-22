part of 'filter.dart';

class StatusSortingFilter implements TodoFilter {
  const StatusSortingFilter();

  @override
  String get description => 'Отсортировано по статусу';

  @override
  Iterable<Todo> exec(Iterable<Todo> todos) sync* {
    yield* todos.where((t) => t.isActual);
    yield* todos.where((t) => !t.isActual);
  }
}

class OnlyActualFilter extends _WhereFilter {
  const OnlyActualFilter() : super(isMatch: _isActual);

  @override
  String get description => 'Только актуальные todo';
}

class OnlyResolvedFilter extends _WhereFilter {
  const OnlyResolvedFilter() : super(isMatch: _isNotActual);

  @override
  String get description => 'Только решенные todo';
}