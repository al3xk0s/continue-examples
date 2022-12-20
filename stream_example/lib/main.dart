import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stream_example/bloc/widget/bloc_provider.dart';
import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';
import 'package:stream_example/models/todo/factory/id_generator.dart';
import 'package:stream_example/models/todo/factory/todo_factory.dart';
import 'package:stream_example/models/todo/impl/todo_model.dart';
import 'package:stream_example/models/todo_list/bloc/bloc.dart';
import 'package:stream_example/models/todo_list/todo_list.dart';
import 'package:stream_example/models/todo_list/repository/todo_repository.dart';
import 'package:stream_example/views/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: TodoListBloc(getTodoList()), 
        child: const TodoListScreen()
      ),
    );
  }

  TodoList getTodoList() {
    final models = <TodoModel>[
      TodoModelImpl(id: TodoId('0'), title: 'Подготовить доклад'),
      TodoModelImpl(id: TodoId('1'), title: 'Рассказать про ппп'),
      TodoModelImpl(id: TodoId('2'), title: 'Послушать Рэп про любовь')
    ];

    return TodoListImpl(
      TodoRepositoryImpl.fromModels(models), 
      TodoFactoryImpl(IdGeneratorImpl(Random())),
    );
  }
}
