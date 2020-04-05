import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';

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
  AppLanguageServiceType _appLanguageService;

  Future<List<Language>> languages;
  Language currentLanguage;

  MainViewModel(this._injector) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
    _languageProvider = _injector.getDependency<LanguageProviderType>();
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _appLanguageService = _injector.getDependency<AppLanguageServiceType>();
  }

  Stream<bool> get loadingIsFinished {
    Observable<bool> isFinished = Observable.combineLatest2(
      _one,
      _two, (one, two) {
        if (!one && two) {
          return true;
        } else {
          return false;
        }
      });

    return isFinished;
  }


  @override
  void initStateSync() {
    languages = _languageProvider.getLanguages();
  }

  @override
  void initState(BuildContext context) {
    _remoteAnalyticsService.setCurrentScreen('main');
    _generatorService.preLoad(context);

    _appLanguageService.getCurrentAppLanguage().then((lang) {
      if (lang != null) {
        AppLocalizations.load(Locale(lang.code, lang.country));
      }
    });
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
    this.currentLanguage = language;
    _appLanguageService.switchAppLanguage(language);
    
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "switch_language");
    _remoteAnalyticsService.sendAnalyticsEvent(event);
  }

}
