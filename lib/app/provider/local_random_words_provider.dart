import 'package:crocodile_game/app/provider/random_words_provider_type.dart';
import 'package:crocodile_game/app/model/word_item.dart';

class LocalRandomWordsProvider implements RandomWordsProviderType {

  final String jsonFileName;

  LocalRandomWordsProvider({this.jsonFileName});

  @override
  Future<List<WordItem>> getAllWords() {
    return Future.value();
  }

  @override
  Future<List<WordItem>> getWordsByCategories() {
    return Future.value();
  }

}
