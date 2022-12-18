abstract class BlocTag {
  const BlocTag();

  static const BlocTag global = GlobalBlocTag();

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

  const HasTag({this.tag = BlocTag.global});
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
