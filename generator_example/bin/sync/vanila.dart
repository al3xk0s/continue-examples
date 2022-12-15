void main(List<String> args) {
  useSyncGenerator();
}

Iterable<int> range(int stop, {int start = 0, int step = 1}) sync* {
  for(int i = start; i < stop; i += step) {
    yield i;
  }
}

void useSyncGenerator() {
  for(final i in range(10)) {
    print(i);
  }
}