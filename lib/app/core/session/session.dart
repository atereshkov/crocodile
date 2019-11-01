import 'package:injector/injector.dart';
import 'package:crocodile_game/app/core/session/session_type.dart';

class Session implements SessionType {

  Session();

  @override
  void registerDependencies(Injector injector) {
    // injector.registerSingleton<OOORequestTypeIdProviderInterface>((_) => OOORequestTypeIdProvider());
  }

}