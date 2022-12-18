import 'package:flutter/material.dart';
import 'package:stream_example/bloc/widget/bloc_builder.dart';
import 'package:stream_example/extentions/context.dart';
import 'package:stream_example/models/todo/abstract/todo.dart';
import 'package:stream_example/models/todo_list/bloc/bloc.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/models/todo_list/bloc/state/state.dart';
import 'package:stream_example/views/todo_widget.dart';


class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoListBloc bloc = context.readBloc()!;

    bloc.emit(TodoListEvent.getData);
    return _getWrapper(
      child: BlocBuilder<TodoListEvent, TodoListState, TodoListBloc>(
        bloc: bloc, 
        builder: _builder,
      ),
    );
  }

  Widget _getWrapper({ required Widget child}) {
    return  DecoratedBox(
      position: DecorationPosition.background,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            spreadRadius: -6,
            blurRadius: 10,
            color: Color.fromARGB(255, 17, 9, 53),
          )
        ]
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 251, 251, 255),
          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        ),
        child: child,        
      ),
    );
  }

  static final _stateBuilderMap = <Type, BlocWidgetBuidler<TodoListEvent, TodoListState, TodoListBloc>>{
    TodoListLoadingState: _loadBuilder,
    TodoListSuccessLoadedState: (c, b, s) =>_loadedState(c, b, s as TodoListSuccessLoadedState),
    TodoListInitialState: _defaultBuilder,
    TodoListEmptyState: _emptyBuilder
  };

  static Widget _loadedState(
    BuildContext context, 
    TodoListBloc bloc, 
    TodoListSuccessLoadedState state
  ) {
    final List<Todo> data = state.todos;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      itemCount: data.length,
      itemBuilder: ((context, index) {
        final todo = data[index];
        return TodoWidget(todo: todo);
      })
    );
  }

  static Widget _emptyBuilder(BuildContext context, _, __) {
    return const Center(
      child: Text(
        'Может быть стоит заняться делами... Ну или отдохнуть',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  static Widget _loadBuilder(BuildContext context, TodoListBloc _, TodoListState __) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  static Widget _defaultBuilder(BuildContext _, TodoListBloc __, TodoListState ___) 
    => const SizedBox.expand();


  Widget _builder(BuildContext context, TodoListBloc bloc, TodoListState state) {
    final handler = _stateBuilderMap[state.runtimeType] ?? _defaultBuilder;
    return handler(context, bloc, state);
  }
}