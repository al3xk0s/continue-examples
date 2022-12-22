import 'package:flutter/material.dart';
import 'package:stream_example/bloc/base/bloc.dart';
import 'package:stream_example/bloc/widget/bloc_provider.dart';

extension ReadBloc on BuildContext {
  B? readBloc<B extends Bloc>() {
    final provider = getElementForInheritedWidgetOfExactType<BlocProvider<B>>()?.widget
      as BlocProvider<B>?;

    return provider?.bloc;
  }
}

extension SnackBarMessage on BuildContext {
  void snackbarMessage(String message, {Duration duration = const Duration(seconds: 4)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      )
    );
  }
}