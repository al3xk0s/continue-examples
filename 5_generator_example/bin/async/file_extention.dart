import 'dart:convert';
import 'dart:io';

extension ReadLineStream on File {
  Stream<String> readAsLineStream({Encoding encoding = utf8}) {
    return openRead().transform(encoding.decoder).transform(const LineSplitter());
  }
}