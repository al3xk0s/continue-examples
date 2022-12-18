import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';

class TodoModelImpl extends TodoModel {
  @override
  late final TodoId id;

  @override
  String get title => _title;

  @override
  bool get isActual => _isActual;

  late bool _isActual;
  late String _title;

  TodoModelImpl({
    required this.id,
    required String title,
    bool isActual = true
  }) {
    _title = title;
    _isActual = isActual;
  }

  @override
  void edit(String title, bool isActual) {
    _title = title;
    _isActual = isActual;
  }
}