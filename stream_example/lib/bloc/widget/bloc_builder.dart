import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_example/bloc/base/bloc.dart';

class BlocBuilder<E, S, B extends Bloc<E, S>> extends StatefulWidget {
  const BlocBuilder({super.key, required this.bloc, required this.builder});

  final B bloc;
  final Widget Function(BuildContext context, B bloc, S state) builder;

  @override
  State<BlocBuilder> createState() => _BlocBuilderState<E, S, B>();
}

class _BlocBuilderState<E, S, B extends Bloc<E, S>> extends State<BlocBuilder> {
  late BlocBuilder<E, S, B> _widget;
  late StreamSubscription<S> _subscription;

  @override
  void initState() {
    _widget = widget as BlocBuilder<E, S, B>;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _subscription = _widget.bloc.out.listen((state) => setState(() {

    }));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = _widget.bloc;
    return _widget.builder(context, bloc, bloc.state);
  }
}