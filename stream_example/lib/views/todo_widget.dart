import 'package:flutter/material.dart';
import 'package:stream_example/bloc/widget/bloc_builder.dart';
import 'package:stream_example/extentions/context.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo_list/bloc/bloc.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/views/todo_edit_dialog_widget.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final TodoListBloc bloc = context.readBloc()!;

    return Card(
      child: ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => bloc.emit(TodoListRemoveTodoEvent(todo.id)),
        ),
        title: Text(
          todo.title, 
          style: TextStyle(
            decoration: todo.isActual ? null : TextDecoration.lineThrough,
          )
        ),
        onTap: () => bloc.emit(TodoSwitchStatusEvent(todo)),
        onLongPress: () => _editTitle(context, bloc),
      ),
    );
  }

  Future<void> _editTitle(BuildContext context, TodoListBloc bloc) async {
    final newTitle = await showDialog<String>(
      context: context, 
      builder: (c) => TodoEditDialogWidget(
        title: 'Время поменять планы...',
        initialValue: todo.title,
      ),
    );

    bloc.emit(TodoEditTitleEvent(todo, newTitle));
  }
}