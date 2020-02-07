import 'dart:math';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/service/team_play/team_play_service_type.dart';
import 'package:flutter/material.dart';

class TeamPlayService implements TeamPlayServiceType {

  List<TeamItem> _allTeams = List<TeamItem>();
  List<TeamItem> _roundTeams = List<TeamItem>();
  TeamItem _currentTeam;
  int _rounds = 0;

  TeamPlayService();

  @override
  Future<void> start(BuildContext context, TeamPlayModeBuilder params) async {
    _allTeams = List.from(params.teams);
    _roundTeams = List.from(params.teams);

    if (params.rounds == 0) {
      _rounds = 999999;
    } else {
      _rounds = params.rounds;
    }
  }

  @override
  Future<TeamItem> getRandomTeam() async {
    var randomTeam = _roundTeams[Random().nextInt(_roundTeams.length)];
    if (_currentTeam != null && randomTeam.id == _currentTeam.id) {
      _currentTeam = _roundTeams.firstWhere((t) => t.id != _currentTeam.id, orElse: () => null);
    } else {
      _currentTeam = randomTeam;
    }
    _roundTeams.remove(_currentTeam);
    return Future.value(_currentTeam);
  }

  @override
  void wordIsGuessed() {
    if (_roundTeams.isEmpty) {
      _rounds--;
      _roundTeams.addAll(_allTeams);
    }
  }

  @override
  void wordIsNotGuessed() {
    if (_roundTeams.isEmpty) {
      _rounds--;
      _roundTeams.addAll(_allTeams);
    }
  }

  bool gameIsActive() {
    return _rounds != 0;
  }

}
