import 'package:flutter/widgets.dart';
import 'package:crocodile_game/app/model/models.dart';

abstract class MainViewModelType {
  void initState();
  void dispose();

  void singlePlayAction(BuildContext context);
  void howToPlayAction(BuildContext context);

  Future<List<Language>> languages;
}