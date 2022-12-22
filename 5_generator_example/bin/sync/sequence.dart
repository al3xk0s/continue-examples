import 'dart:io';

import 'vanila.dart';

void main(List<String> args) {
  Sequence.fibonacci(20).forEach((f) {
    sleep(Duration(milliseconds: 50));
    print(f);
  });
}

abstract class Sequence {
  static Iterable<int> fibonacci([int limit = -1])  {
    if(limit <= -1) return _unlimitedFibonacci();
    if(limit == 0) return const [];
    return _limitedFibonacci(limit);
  }

  static Iterable<int> arithmeticProgression(int initial, int step, int limit) sync* {
    yield* range(limit, start: initial, step: step);
  }
  
  static Iterable<int> _unlimitedFibonacci() {
    return _fibonacci((next) => true);
  }

  static Iterable<int> _limitedFibonacci(int limit) {
    return _fibonacci((next) => next < limit);
  }

  static Iterable<int> _fibonacci(bool Function(int next) needContinue) sync* {
    int previos = 0;
    yield previos;
    int current = 1;

    int getNext() => previos + current;

    while(needContinue(current)) {
      yield current;
      int next = getNext();
      previos = current;
      current = next;     
    }
  }
}