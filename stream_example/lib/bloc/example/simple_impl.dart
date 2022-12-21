import 'package:stream_example/bloc/example/simple_base.dart';
import 'package:stream_example/bloc/example/simple_repository.dart';

abstract class ExampleEvent {}

class GetDataEvent extends ExampleEvent {}

class GetDataCountEvent extends ExampleEvent {
  GetDataCountEvent(this.count);
  final int count;
}


abstract class ExampleState {}

class InitialState extends ExampleState {}
class LoadingState extends ExampleState {}

class SuccessState extends ExampleState {
  SuccessState(this.data);
  final List<String> data;
}

class FailedState<E extends Exception> extends ExampleState {
  FailedState(this.error);
  final E error;
}

class ExampleBloc extends SimpleBlocBase<ExampleEvent, ExampleState> {
  ExampleBloc(this.repository);
  final SimpleRepository repository;

  @override
  Stream<ExampleState> mapEventToState(ExampleEvent event) async* {
    late Future<List<String>> Function() getData;

    if(event is GetDataEvent) getData = repository.getData;
    if(event is GetDataCountEvent) getData = () => repository.getDataCount(event.count);

    yield LoadingState();

    try {
      List<String> data = await getData();
      yield SuccessState(data);
    } catch (e) {
      yield FailedState(e as Exception);
    }
  }
}