import 'package:stream_example/models/todo/abstract/todo.dart';

abstract class TodoModel extends Todo {
  void switchStatus();
  void rename(String title);
}

