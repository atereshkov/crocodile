import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/service/generator_service.dart';
import 'package:injector/injector.dart';
import 'package:crocodile_game/app/core/session/session_type.dart';
import 'package:crocodile_game/app/service/services.dart';

class Session implements SessionType {

  Session();

  @override
  void registerDependencies(Injector injector) {  
    final wordProvider = LocalRandomWordsProvider();

    injector.registerSingleton<GeneratorServiceType>((_) => GeneratorService(wordProvider));
  }

}