import 'package:stream_example/models/todo/todo_required_field.dart';

class TodoId extends TodoRequiredField {
  TodoId(super.value);
}

class TodoTitle extends TodoRequiredField {
  TodoTitle(super.value);
}

class Todo {
  late final TodoId id;

  String get title => _title.value;
  String get description => _description;
  bool get isActual => _isActual;

  late bool _isActual;
  late TodoTitle _title;
  late String _description;

  Todo({
    required String id,
    required String title,
    String description = "",
    bool isActual = true
  }) {
    this.id = TodoId(id);
    _title = TodoTitle(title);
    _description = description;
    _isActual = isActual;
  }

  @override
  bool operator==(covariant Todo other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  void resolve() {
    _isActual = false;
  }

  void actualize() {
    _isActual = true;
  }
}
