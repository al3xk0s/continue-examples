import 'package:stream_example/models/todo/abstract/todo_id.dart';
import 'package:stream_example/models/todo/abstract/todo_model.dart';
import 'package:stream_example/models/todo/factory/id_generator.dart';
import 'package:stream_example/models/todo/impl/todo_model.dart';

abstract class TodoFactory {
  TodoModel create({required TodoId id, required String title, bool isActual = true});
  TodoId createId();
}



class TodoFactoryImpl implements TodoFactory {
  const TodoFactoryImpl(this.idGenerator);
  
  final IdGenerator idGenerator;

  @override
  TodoModel create({required TodoId id, required String title, bool isActual = true}) {
    return TodoModelImpl(
      id: id,
      title: title,
      isActual: isActual
    );
  }
  
  @override
  TodoId createId() {
    return TodoId(idGenerator.generate(30));
  }
}