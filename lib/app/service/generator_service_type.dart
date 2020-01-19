import 'package:flutter/widgets.dart';
import 'package:crocodile_game/app/model/models.dart';

abstract class GeneratorServiceType {
  Future<void> start(BuildContext context, List<CategoryInfoItem> categories);
  Future<String> getRandomWord(BuildContext context);
}
