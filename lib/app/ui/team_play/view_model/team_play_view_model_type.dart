import 'package:crocodile_game/app/model/enum/enums.dart';
import 'package:flutter/material.dart';

abstract class TeamPlayViewModelType {
  Stream<String> get item;
  Stream<TeamPlayMode> get mode;

  void initState(BuildContext context);
  void generateNewWordAction(BuildContext context);
  void dispose();
}