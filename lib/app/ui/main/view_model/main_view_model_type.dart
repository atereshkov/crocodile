import 'package:flutter/widgets.dart';
import 'package:crocodile_game/app/model/models.dart';

abstract class MainViewModelType {
  void initStateSync();
  void initState(BuildContext context);
  void dispose();

  void singlePlayAction(BuildContext context);
  void howToPlayAction(BuildContext context);
  void languageDropDownAction(Language language);

  Future<List<Language>> languages;
}