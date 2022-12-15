void main(List<String> args) {
  useAsyncGenerator();
}

Future<void> useAsyncGenerator() async {
  final delay = const Duration(milliseconds: 100);
  await for(int i in asyncRange(10, delay)) {
    print(i);
  }
}

Future<int> useAsyncGeneratorWithoutAwaitFor() {
  int sum = 0;
  return asyncRange(10, const Duration(microseconds: 10))
  .listen((number) {
    sum += number;
  })
  .asFuture(sum);
}

Stream<int> asyncRange(int stop, Duration delay) async* {
  for(int i = 0; i < stop; i++) {
    await Future.delayed(delay);
    yield i;
  }
}

typedef AsyncRangeGenerator = Stream<int> Function(int stop, Duration delay);

Stream<int> multiRange(List<AsyncRangeGenerator> generators) async* {
  final delay = const Duration(milliseconds: 100);
  for(final AsyncRangeGenerator generator in generators) {
    // Делегирование другому генератору
    yield* generator(10, delay);
  }
}