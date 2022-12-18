import 'package:flutter/material.dart';

class TodoEditDialogWidget extends StatelessWidget {
  const TodoEditDialogWidget({super.key, required this.title, this.initialValue});

  final String title;
  final String? initialValue;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextFormField(
        initialValue: initialValue,
        validator: (value) => null,
        autofocus: true,
        onFieldSubmitted: (value) => Navigator.pop(context, value),
      ),
    );
  }

  // void onSubmited(BuildContext context, String value) {
  //   if(value)
  // }
}