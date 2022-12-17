void main() {
  final chestTable = getChestTable(15);

  print('Шахматная доска');
  for (String line in chestTable) {
    print(line);
  }
}

T Function() getItemProvider<T>(List<T> items) {
  int index = -1;
  return () {
    index = (index + 1) % items.length;
    return items[index];
  };
}

List<String> getChestTable(int size) {
  String Function() getItem = getItemProvider(const ['#', '.']);
  List<String> result = [];

  List<String> lineBuffer = [];
  for (var i = 0; i < size; i++) {

    for (var j = 0; j < size; j++) {
      lineBuffer.add(getItem());
    }

    if (size % 2 == 0) getItem();

    result.add(lineBuffer.join());
    lineBuffer.clear();
  }
  return result;
}


  // Вывод:
  //
  // Шахматная доска
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#
  // .#.#.#.#.#.#.#.
  // #.#.#.#.#.#.#.#