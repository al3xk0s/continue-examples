import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:stream_example/models/todo/todo.dart';
import 'package:stream_example/views/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  List<Todo> _getTodos() {
    return [
      Todo(id: '0', title: '123', description: ''),
      Todo(id: '0', title: '123', description: ''),
      Todo(id: '0', title: '123', description: ''),
      Todo(id: '0', title: '123', description: ''),
      Todo(id: '0', title: '123', description: ''),
      Todo(id: '0', title: '123', description: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: _getTodos().map((t) => TodoWidget(todo: t)).toList(),
      
    );
  }
}