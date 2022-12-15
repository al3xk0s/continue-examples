import 'package:flutter/material.dart';
import 'package:stream_example/bloc/base/bloc.dart';
import 'package:stream_example/bloc/base/bloc_handle_storage.dart';
import 'package:stream_example/bloc/widget/bloc_builder.dart';
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
      home: const TodoListScreen(),
    );
  }
}
