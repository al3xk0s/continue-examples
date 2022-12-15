import 'package:generator_example/generator_example.dart' as generator_example;
import 'dart:async';

void main(List<String> arguments) {
  print('Hello world: ${generator_example.calculate()}!');
}



Stream<int> asyncGenerator(int limit) async* {
  for(int i = 0; i < limit; i++) {
    await Future.delayed(const Duration(milliseconds: 200));
    yield i;
  }
}

Future<int> useAsyncGenerator() async {
  int sum = 0;
  await for(final int i in asyncGenerator(10)) {
    sum += i;
  }
  return sum;
}

Future<int> useAsyncGeneratorWithoutAwaitFor() {
  int sum = 0;
  return asyncGenerator(10).listen((number) {
    sum += number;
  })
  .asFuture(sum);
}

Future<List<T>> getListOfStream<T>(Stream<T> stream) async {
  final List<T> result = [];
  await for(final T i in stream) {
    result.add(i);
  }
  return result;
}
