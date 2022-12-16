abstract class BlocTag {
  const BlocTag();

  bool equals(BlocTag other);
  int getHashcode();

  @override
  operator==(covariant BlocTag other) {
    return hashCode == other.hashCode || equals(other);
  }

  @override
  int get hashCode => getHashcode();
}

abstract class HasTag {
  final BlocTag tag;

  const HasTag({this.tag = const GlobalBlocTag()});
}

class GlobalBlocTag implements BlocTag {
  const GlobalBlocTag();
  
  @override
  bool equals(BlocTag other) {
    return super == other;
  }
  
  @override
  int getHashcode() {
    return hashCode;
  }
}
