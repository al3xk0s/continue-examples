import 'package:flutter/material.dart';
import 'package:stream_example/bloc/widget/bloc_builder.dart';
import 'package:stream_example/extentions/context.dart';
import 'package:stream_example/models/todo_list/bloc/bloc.dart';
import 'package:stream_example/models/todo_list/bloc/event/event.dart';
import 'package:stream_example/models/todo_list/bloc/state/state.dart';
import 'package:stream_example/models/todo_list/todo_filter/filter.dart';

class TodoFitlerSwitchWidget extends StatelessWidget {
  const TodoFitlerSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListEvent, TodoListState, TodoListBloc>(
      bloc: context.readBloc()!, 
      builder: (context, bloc, state) {
        if(state is! HasFilterState) return _getDefaultWidget();

        return IconButton(
          icon: _filterIconMap[state.filter]!,
          onPressed: () => bloc.emit(TodoListNextFilterEvent(state.filter)),
        );
      }
    );
  }

  Widget _getDefaultWidget() {
    return const SizedBox.shrink();
  }

  static const _filterIconMap = {
    TodoFilter.sorting : Icon(Icons.sort),
    TodoFilter.onlyActual : Icon(Icons.calendar_month),
    TodoFilter.onlyResolved : Icon(Icons.check),
  };
}