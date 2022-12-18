class TodoId {
  TodoId(this.value) : assert(value.isNotEmpty);

  final String value;

  @override
  operator==(covariant TodoId other) {
    return value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

