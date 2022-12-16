import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';

abstract class TodoFactory {
  TodoModel create({required String title, bool isActual = true});
  TodoId createId(String id);
}