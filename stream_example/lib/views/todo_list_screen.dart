import 'package:flutter/material.dart';
import 'package:stream_example/extentions/context.dart';
import 'package:stream_example/models/todo_list/bloc/bloc.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/views/todo_edit_dialog_widget.dart';
import 'package:stream_example/views/todo_filter_switch_widget.dart';
import 'package:stream_example/views/todo_list_widget.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double padding = 12;

    _attachToTitleEvents(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40),
            child: TodoFitlerSwitchWidget(),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: const TodoListWidget(),
      ),
      floatingActionButton: _getButton(
        context: context, 
        size: 100, 
        padding: padding
      ),
    );
  }

  Widget _getButton({ required BuildContext context, required double size, required double padding}) {
    final TodoListBloc bloc = context.readBloc()!;

    return Container(
      padding: EdgeInsets.all(padding),
      height: size,
      width: size,
      child: FloatingActionButton(
        autofocus: true,
        child: Icon(Icons.add, size: size * 0.4),
        onPressed: () => _createTodo(context, bloc),
      ),
    );
  }

  Future<void> _createTodo(BuildContext context, TodoListBloc bloc) async {
    final String? todoTitle = await showDialog<String>(
      context: context, 
      builder: (context) => const TodoEditDialogWidget(
        title: 'Чем сегодня займемся',
      ),
    );

    bloc.emit(TodoListCreateTodoEvent(todoTitle));
  }

  void _attachToTitleEvents(BuildContext context) {
    final TodoListBloc bloc = context.readBloc()!;

    bloc.onEvent<TodoListInvalidTodoTitleEvent>((e) => _handleEventMessage(context, e));
    bloc.onEvent<TodoListEmptyTodoTitleEvent>((e) => _handleEventMessage(context, e));
    bloc.onEvent<TodoListChangedTitleEvent>((e) => _handleEventMessage(context, e));
    bloc.onEvent<TodoListTodoResolvedEvent>((e) => _handleEventMessage(context, e));
    bloc.onEvent<TodoListTodoActualizeEvent>((e) => _handleEventMessage(context, e));
    bloc.onEvent<TodoListTodoRemovedEvent>((e) => _handleEventMessage(context, e));
  }

  void _handleEventMessage(BuildContext context, TodoListMessageEvent event) {
    if(event.message == null) return;

    context.snackbarMessage(
      event.message!, 
      duration: const Duration(seconds: 1, milliseconds: 500)
    );
  }
}