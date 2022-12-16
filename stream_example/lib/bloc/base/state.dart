import 'package:stream_example/bloc/base/tag.dart';

abstract class BlocState extends HasTag {
  const BlocState({super.tag});
}
