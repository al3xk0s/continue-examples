import 'package:stream_example/bloc/base/tag.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';

abstract class TodoListBlocTag extends BlocTag {}

class TodoListIdBlocTag implements TodoListBlocTag {
  const TodoListIdBlocTag(this.id);

  final TodoId id;

  @override
  bool equals(covariant BlocTag other) {
    if(other is! TodoListIdBlocTag) return false;
    return id == other.id;
  }

  @override
  int getHashcode() {
    return id.hashCode;
  }

}