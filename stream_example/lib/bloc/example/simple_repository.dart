abstract class SimpleRepository {
  Future<List<String>> getData();

  Future<List<String>> getDataCount(int count);
}