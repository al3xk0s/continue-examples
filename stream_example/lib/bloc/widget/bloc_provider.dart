import 'package:flutter/widgets.dart';
import 'package:stream_example/bloc/base/bloc.dart';

class BlocProvider<B extends Bloc> extends InheritedWidget {
const BlocProvider({super.key, required this.bloc, required super.child});

  final B bloc;

  @override
  bool updateShouldNotify(covariant BlocProvider<B> oldWidget) {
    return false;
  }
}
