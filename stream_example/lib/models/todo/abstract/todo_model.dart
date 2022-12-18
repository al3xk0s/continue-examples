import 'package:stream_example/models/todo/abstract/todo.dart';

abstract class TodoModel extends Todo {
  void edit(String title, bool isActual);
}

