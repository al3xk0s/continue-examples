void main(List<String> args) {
  final memoisedCounter = createCounter();
  final regularCounter = createCounter();

  final int Function(int) getFactorialMemoized = createMemoizedFactorial(memoisedCounter);

  getFactorial(30, regularCounter);
  getFactorial(40, regularCounter);

  getFactorialMemoized(30);
  getFactorialMemoized(40);

  print('Обычный факториал: ${regularCounter() - 1}');
  print('Мемный факториал: ${memoisedCounter() - 1}');

  // Вывод:
  //
  // Обычный факториал: 67
  // Мемный факториал: 39
}

R Function(T) createMemoizedFunction<T, R>(R Function(T) executor) {
  final Map<T, R> cache = {};
  return (T arg) {
    final R? cachedValue = cache[arg];
    if(cachedValue != null) {
      return cachedValue;
    }

    final R value = executor(arg);
    cache[arg] = value;

    return value;
  };
}

int getFactorial(int value, void Function() onIteration) {
  if(value < 2) return 1;
  onIteration();
  return value * getFactorial(value - 1, onIteration);
}

int Function(int) createMemoizedFactorial(void Function() onIteration) {
  late int Function(int) factorialMemoized;

  factorialMemoized = createMemoizedFunction((int value) {
    if(value < 1) return 1;
    onIteration();
    return value * factorialMemoized(value - 1);
  });

  return factorialMemoized;
}

int Function() createCounter([int start = 0]) {
  return () => start++;
}