import 'package:flutter/widgets.dart';

abstract class GeneratorServiceType {
  Future<String> getRandomWord(BuildContext context);
}
