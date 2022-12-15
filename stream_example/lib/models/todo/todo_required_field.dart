abstract class TodoRequiredField {
  TodoRequiredField(this.value) : assert(value.isNotEmpty);
  
  final String value;

  @override
  bool operator==(covariant TodoRequiredField other) {
    return value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return value;
  }
}
