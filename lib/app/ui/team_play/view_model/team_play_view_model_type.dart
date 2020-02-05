import 'package:crocodile_game/app/model/enum/enums.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class TeamPlayViewModelType {
  Stream<String> get item;
  Stream<TeamPlayMode> get mode;
  Stream<TeamItem> get currentTeam;
  Stream<int> get roundsLeft;

  void initState(BuildContext context);
  void startGameAction(BuildContext context);
  void wordGuessedAction(BuildContext context);
  void wordNotGuessedAction(BuildContext context);
  void endGameAction(BuildContext context);
  void nextTeamPlayAction(BuildContext context);
  void shareResultsAction(BuildContext context);
  void playAgainAction(BuildContext context);
  void dispose();
}