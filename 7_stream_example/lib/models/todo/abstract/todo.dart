import 'package:stream_example/models/todo/abstract/todo_id.dart';

abstract class Todo {
  TodoId get id;
  String get title;
  bool get isActual;

  @override
  bool operator==(covariant Todo other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}