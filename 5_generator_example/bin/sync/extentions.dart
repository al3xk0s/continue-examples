import 'dart:math';

extension FindIndex<T> on List<T> {
  int findIndex(T item, {int start = 0, int end = -1}) {
    if(start < 0) throw ArgumentError.value(start);
    end = end < 0 ? length : end;

    for (var i = start; i < end; i++) {
      if(this[i] == item) return i;
    }

    return -1;
  }
}

extension RandomOfValues on Random {
  T ofValues<T>(List<T> source) {
    if(source == 0) throw Exception();
    return source[nextInt(source.length)];
  }
}