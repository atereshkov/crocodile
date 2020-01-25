import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class SelectTeamViewModelType {
  Stream<List<TeamItem>> get getTeamsStream;
  Stream<bool> get startGameButtonEnabledStream;
  Stream<bool> get isTimerChecked;
  Stream<String> get timerValue;

  void startGameAction(BuildContext context);
  void handleTeamItemTap(TeamItem item);
  void onTeamDeleteTap(TeamItem item);
  void onTimerCheckboxAction(bool value);
  void timerDropdownAction(String value);

  void initState(BuildContext context);
  void dispose();
}