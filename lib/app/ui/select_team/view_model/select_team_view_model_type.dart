import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class SelectTeamViewModelType {
  Stream<List<TeamItem>> get getTeamsStream;
  Stream<bool> get startGameButtonEnabledStream;
  Stream<bool> get isTimerChecked;
  Stream<String> get timerValue;

  void startGameAction(BuildContext context);
  void handleTeamItemTap(BuildContext context, TeamItem item);
  void onTeamDeleteTap(TeamItem item);
  void onTeamRenameTap(BuildContext context, TeamItem item);
  void onTimerCheckboxAction(bool value);
  void timerDropdownAction(String value);
  void addTeamAction(BuildContext context);

  void initState(BuildContext context);
  void dispose();
}