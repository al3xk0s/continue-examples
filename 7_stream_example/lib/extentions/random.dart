import 'dart:math';

extension RandomOfValues on Random {
  T ofValues<T>(List<T> values) {
    if(values.isEmpty) throw Exception('List must contains many values');

    final int index = nextInt(values.length);
    return values[index];
  }
}