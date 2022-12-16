import 'package:stream_example/bloc/base/tag.dart';

abstract class BlocEvent extends HasTag {
  const BlocEvent({super.tag});
}