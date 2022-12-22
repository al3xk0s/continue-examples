import 'dart:io';

import 'file_extention.dart';

const FILE_PATH = 'numbers.txt';

void main(List<String> args) async {
  final int sum = await getSumOfFileNumbers();
  print(sum);
}

Future<int> getSumOfFileNumbers() async {
  int sum = 0;

  Stream<int?> numbers = File(FILE_PATH)
    .readAsLineStream()
    .asyncMap(int.tryParse);

  await for(final int? number in numbers) {
    if(number != null) sum += number;
  }

  return sum;
}

// Вывод: 55