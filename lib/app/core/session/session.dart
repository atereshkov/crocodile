import 'package:injector/injector.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/core/session/session_type.dart';
import 'package:crocodile_game/app/service/services.dart';

class Session implements SessionType {

  Session();

  @override
  void registerDependencies(Injector injector) {  
    final wordProvider = LocalRandomWordsProvider();

    injector.registerSingleton<GeneratorServiceType>((_) => GeneratorService(wordProvider));
    injector.registerSingleton<RemoteAnalyticsServiceType>((_) => FirebaseAnalyticsService());
    injector.registerSingleton<LanguageProviderType>((_) => LanguageProvider());
  }

}