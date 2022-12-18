import 'dart:math';

import 'package:stream_example/extentions/random.dart';

class _Probability {
  const _Probability(this.value) : assert(value >= 0 && value <= 100);
  final int value;
}

abstract class _MessageGenerator {
  _MessageGenerator({this.generateMessageProbability = const _Probability(2)});

  final Random _gen = Random();
  final _Probability generateMessageProbability;

  String? getMessage(String source) {
    final probValue = _gen.nextInt(101);
    if(probValue > generateMessageProbability.value) return null;
    return generate(source);
  }

  String generate(String source);
}

class _MessageGeneratorRandom extends _MessageGenerator {
  _MessageGeneratorRandom(this.values, {super.generateMessageProbability});

  final List<String> values;

  @override
  String generate(String source) {
    return _gen.ofValues(values);
  }
}

class _MessageLeftRigth extends _MessageGenerator {
  _MessageLeftRigth(this.leftValues, this.rigthValues, {super.generateMessageProbability});

  final List<String> leftValues;
  final List<String> rigthValues;

  @override
  String generate(String source) {
    final List<String> sourceList = _gen.nextBool() ? leftValues : rigthValues;
    final String phrase = _gen.ofValues(sourceList);

    return sourceList == leftValues ?
      '$phrase "${source.toLowerCase()}"' :
      '"$source", $phrase';
  }
}

String? Function(String) _getEmptyTitleMessageGenerator(_Probability prob) {
  const values = <String>[
    'Передумал?',
    'И кто это у нас такой нерешительный?',
    'А я думал, это мне сложно спланировать свой день',
    'Правильно, а ну его',
  ];

  return _MessageGeneratorRandom(values, generateMessageProbability: prob).getMessage;
}

String? Function(String) _getInvalidTitleMessageGenerator(_Probability prob) {
  const values = [
    'Так дело не пойдет...',
    'Да придумай ты уже, чем себя занять..',
    'Тут тебе туду лист, а не бордель',
  ];

  return _MessageGeneratorRandom(
    values, 
    generateMessageProbability: prob,
  ).getMessage;
}

String? Function(String) _getChangeTitleMessageGenerator(_Probability prob) {
  const leftValues = [
    'Понятно...',
    'У тебя больше дел нет, кроме как',
    'Эх, вот помню в молодости я тоже любил',
    'А вот роботам чужды все эти ваши дела по типу',
  ];

  const rigthValues = [
    'интересненько...',
    'позовешь посмотреть?',
    'а можно с тобой?',
  ];

  return _MessageLeftRigth(
    leftValues, 
    rigthValues, 
    generateMessageProbability: prob,
  ).getMessage;
}

String? Function(String) _getRemoveMessageGenerator(_Probability prob) {
  final leftValues = [
    'Сегодня нас покинул ещё один друг:',
    'Люблю грозу в начале мая. Кстати, тут выпилилась одна задача, как бишь её... А,',
    'И приказала она долго жить, эта ваша:',
  ];

  final rigthValues = [
    'ещё одна задача покинула наш мир...',
    'была так молода... За что!!?',
    'не суждено сбыться... Или суждено?',
  ];

  return _MessageLeftRigth(
    leftValues, 
    rigthValues,
    generateMessageProbability: prob,
  ).getMessage;
}

String? Function(String) _getResolveMessageGenerator(_Probability prob) {
  const values = [
    'Ай, молодец!',
    'Блестящая продуктивность',
    'Так держать, пес!',
    'Сегодня у тебя появился первый друг',
  ];

  return _MessageGeneratorRandom(values, generateMessageProbability: prob).getMessage;
}

const _regularProb = _Probability(10);
const _highProb = _Probability(95);

final getEmptyTitleMessage = _getEmptyTitleMessageGenerator(_regularProb);
final getInvalidTitleMessage = _getInvalidTitleMessageGenerator(_highProb);
final getChangeTitleMessage = _getChangeTitleMessageGenerator(_highProb);
final getRemoveTodoMessage = _getRemoveMessageGenerator(_highProb);
final getResolveTodoMessage = _getResolveMessageGenerator(_regularProb);
final getActualizeTodoMessage = _getInvalidTitleMessageGenerator(_regularProb);