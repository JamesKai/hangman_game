import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class ParseFiler {
  static Future<Set<String>> getWords({@required String from}) async {
    String data = await rootBundle.loadString(from);
    return LineSplitter.split(data).where((word) => isOkWord(word)).toSet();
  }

  static bool isOkWord(String word) {
    RegExp pattern = RegExp(r"[^(A-Z\.'?!\s\d\-\+)]+");
    return pattern.hasMatch(word);
  }
}
