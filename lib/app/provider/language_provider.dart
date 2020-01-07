import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';

class LanguageProvider implements LanguageProviderType {

  @override
  Future<List<Language>> getLanguages() async {
    List<Language> languages = [];

    Language en = Language(1, 'English', 'en', 'US');
    languages.add(en);

    Language ru = Language(1, 'Русский', 'ru', 'RU');
    languages.add(ru);

    return Future.value(languages);
  }

}