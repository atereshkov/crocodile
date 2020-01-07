import 'package:crocodile_game/app/model/models.dart';

abstract class LanguageProviderType {
  Future<List<Language>> getLanguages();
}
