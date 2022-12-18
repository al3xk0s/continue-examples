import 'dart:math';

abstract class IdGenerator { String generate(int length); }

class IdGeneratorImpl implements IdGenerator {
  const IdGeneratorImpl(this.generator);
  final Random generator;

  static final alfabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789=-'
    .split('');

  String generate(int length) {
    final StringBuffer result = StringBuffer();
    for(int i = 0; i < length; i++) {
      int index = generator.nextInt(alfabet.length);
      result.write(alfabet[index]);
    }
    return result.toString();
  }
}