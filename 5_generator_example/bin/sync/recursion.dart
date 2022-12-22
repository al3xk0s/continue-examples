import 'extentions.dart';

void main(List<String> args) {
  Itertools.subset(3).forEach((s) {
    print(s);
  });

  print('');

  Iterable<List<String>> permutations = Itertools.permutations(const ['a', 'b', 'c']);

  permutations.forEach((permutation) {
    print(permutation);
  });

  // [false, false, false]
  // [false, false, true]
  // [false, true, false]
  // [false, true, true]
  // [true, false, false]
  // [true, false, true]
  // [true, true, false]
  // [true, true, true]
  // 
  // [a, b, c]
  // [a, c, b]
  // [b, a, c]
  // [b, c, a]
  // [c, a, b]
  // [c, b, a]
}

abstract class Itertools {
  static Iterable<List<bool>> subset(int length) {
    return _recursiveSubset(List.filled(length, true), 0);
  }

  static Iterable<List<bool>> _recursiveSubset(List<bool> subset, int position) sync* {
    if (position == subset.length) {
      yield subset.toList();
      return;
    }
    subset[position] = false;
    yield* _recursiveSubset(subset, position + 1);
    subset[position] = true;
    yield* _recursiveSubset(subset, position + 1);
  }

  static Iterable<List<T>> permutations<T>(Iterable<T> source) sync* {
    final Iterable<Iterable<int>> permuts = _recursivePermuts(List.filled(source.length, 0), 0);

    for (Iterable<int> indexes in permuts) {
      yield indexes.map((i) => source.elementAt(i)).toList();
    }

    // return permuts.map( 
    //   (Iterable<int> indexes) => indexes.map((int i) => source.elementAt(i)),
    // );
  }

  static Iterable<Iterable<int>> _recursivePermuts(List<int> permutations, int position) sync* {
    if(position == permutations.length) {
      yield permutations.where((e) => true);
      return;
    }

    for (var i = 0; i < permutations.length; i++) {
      int index = permutations.findIndex(i, start: 0, end: position);
      if(index != -1) continue;

      permutations[position] = i;
      yield* _recursivePermuts(permutations, position + 1);
    }
  }
}
