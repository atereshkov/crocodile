import 'package:crocodile_game/app/model/models.dart';

abstract class AppLanguageServiceType {
  Future<Language> getCurrentAppLanguage();
  Future<void> switchAppLanguage(Language language);
}
