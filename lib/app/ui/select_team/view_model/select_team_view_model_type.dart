import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class SelectTeamViewModelType {
  Stream<List<TeamItem>> get getTeamsStream;
  Stream<bool> get startGameButtonEnabledStream;

  void startGameAction(BuildContext context);
  void handleTeamItemTap(TeamItem item);

  void initState(BuildContext context);
  void dispose();
}