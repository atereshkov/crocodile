import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:crocodile_game/app/ui/main/module.dart';
import 'package:crocodile_game/app/ui/select_game/module.dart';
import 'package:crocodile_game/app/ui/rules/module.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';

class MainViewModel implements MainViewModelType {
  Injector _injector;
  RemoteAnalyticsServiceType _remoteAnalyticsService;
  LanguageProviderType _languageProvider;
  GeneratorServiceType _generatorService;

  Future<List<Language>> languages;

  MainViewModel(this._injector) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
    _languageProvider = _injector.getDependency<LanguageProviderType>();
    _generatorService = _injector.getDependency<GeneratorServiceType>();
  }

  @override
  void initStateSync() {
    languages = _languageProvider.getLanguages();
  }

  @override
  void initState(BuildContext context) {
    _remoteAnalyticsService.setCurrentScreen('main');
    _generatorService.preLoad(context);
  }

  @override
  void dispose() {
    
  }

  @override
  void singlePlayAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'select_game', 'from': 'main' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    SelectGameViewModelType vm = SelectGameViewModel(_injector);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectGamePage(vm)));
  }

  @override
  void howToPlayAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'rules', 'from': 'main' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    RulesViewModelType vm = RulesViewModel(_injector);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RulesPage(vm)));
  }

  @override
  void languageDropDownAction(Language language) {
    AppLocalizations.load(Locale(language.code, language.country));
    
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "switch_language");
    _remoteAnalyticsService.sendAnalyticsEvent(event);
  }

}
