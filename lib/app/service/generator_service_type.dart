import 'package:flutter/widgets.dart';

abstract class GeneratorServiceType {
  void start(BuildContext context);
  Future<String> getRandomWord(BuildContext context);
}
