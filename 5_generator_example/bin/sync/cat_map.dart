import 'dart:math';

import 'extentions.dart';
import 'vanila.dart';

extension CatMap<T> on Iterable<T> {
  static const _cats = [
    '🐱', '🐈', '😼', '😹', '🙀', '😾', '😿', '😻', '😺', '😸', '😽'
  ];

  Iterable<R> catMap<R>(R Function(T item, String cat) mapper) sync* {
    final Random random = Random();
    for (var item in this) {
      yield mapper(item, random.ofValues(_cats));
    }
  }
}

void main(List<String> args) {
  range(10).catMap((i, cat) => '$i: $cat').forEach((catValue) {
    print(catValue);
  });

  // Вывод:
  //
  // 0: 😽
  // 1: 😹
  // 2: 🙀
  // 3: 😸
  // 4: 😺
  // 5: 😺
  // 6: 🙀
  // 7: 🙀
  // 8: 😼
  // 9: 😽
}