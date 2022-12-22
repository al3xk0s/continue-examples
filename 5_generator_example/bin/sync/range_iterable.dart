void main(List<String> args) {
  useRangeIterable();
}

void useRangeIterable() {
  for(int i in RangeIterable(10)) {
    print(i);
  }
}

class RangeIterable extends Iterable<int> {
  const RangeIterable(this.stop, {this.start = 0, this.step = 1});

  final int start;
  final int step;
  final int stop;

  @override
  Iterator<int> get iterator => RangeIterator(start, stop, step);
}

class RangeIterator extends Iterator<int> {
  RangeIterator(this.start, this.stop,  this.step);

  final int start;
  final int step;
  final int stop;

  late int _current = start - step;

  @override
  int get current => _current;

  @override
  bool moveNext() {
    final int expected = _current + step;

    if(expected >= stop) return false;

    _current = expected;
    return true;
  }

}

// Вывод:
//
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9