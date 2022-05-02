void main() {
  int Function() counter = getCounter();
  print('Счетчик');
  print(counter());
  print(counter());
  print(counter());
  print('');
}

int Function() getCounter([int start = 0, int step = 1]) {
  return () {
    int value = start;
    start += step;
    return value;
  };
}
