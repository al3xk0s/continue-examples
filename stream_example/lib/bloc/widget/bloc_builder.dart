import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_example/bloc/base/bloc.dart';
import 'package:stream_example/bloc/base/event.dart';
import 'package:stream_example/bloc/base/state.dart';
import 'package:stream_example/bloc/base/tag.dart';

class BlocBuilder<
    E extends BlocEvent, 
    S extends BlocState, 
    B extends Bloc<E, S>
> extends StatefulWidget {
  const BlocBuilder({super.key, required this.bloc, required this.builder, this.tag = const GlobalBlocTag()});

  final B bloc;
  final Widget Function(BuildContext context, B bloc, S state) builder;
  final BlocTag tag;

  @override
  State<BlocBuilder> createState() => _BlocBuilderState<E, S, B>();
}

class _BlocBuilderState<
    E extends BlocEvent, 
    S extends BlocState, 
    B extends Bloc<E, S>
> extends State<BlocBuilder> {
  late BlocBuilder<E, S, B> _widget;
  late StreamSubscription<S> _subscription;

  @override
  void initState() {
    _widget = widget as BlocBuilder<E, S, B>;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _subscription = _widget.bloc.out.listen((state) {
      if(state.tag != widget.tag) return;
      setState(() { });
    });
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