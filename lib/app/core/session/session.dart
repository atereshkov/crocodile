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

    final teamNameProvider = LocalRandomNamesProvider();
    injector.registerSingleton<TeamGeneratorServiceType>((_) => TeamGeneratorService(teamNameProvider));
    injector.registerSingleton<TeamPlayServiceType>((_) => TeamPlayService());
    injector.registerSingleton<AudioPlayerType>((_) => AudioPlayer());

    injector.registerSingleton<RemoteAnalyticsServiceType>((_) => FirebaseAnalyticsService());
    injector.registerSingleton<LanguageProviderType>((_) => LanguageProvider());
    injector.registerSingleton<CategoryProviderType>((_) => CategoryProvider());

    injector.registerSingleton<AppLanguageServiceType>((_) => AppLanguageService());
  }

}