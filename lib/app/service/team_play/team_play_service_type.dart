import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/widgets.dart';

abstract class TeamPlayServiceType {
  Future<void> start(BuildContext context, TeamPlayModeBuilder params);
  Future<TeamItem> getRandomTeam();
  void wordIsGuessed();
  void wordIsNotGuessed();

  bool gameIsActive();
}
