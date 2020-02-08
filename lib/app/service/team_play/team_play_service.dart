import 'dart:math';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/service/team_play/team_play_service_type.dart';
import 'package:flutter/material.dart';

class TeamPlayService implements TeamPlayServiceType {

  List<TeamItem> _allTeams = List<TeamItem>();
  List<TeamItem> _roundTeams = List<TeamItem>();
  TeamItem _currentTeam;
  int _rounds = 0;

  final Map<String, int> teamPoints = {};

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

    teamPoints.clear();
    _allTeams.forEach((team) {
      teamPoints[team.id] = 0;
    });
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
    if (teamPoints[_currentTeam.id] == null) {
      teamPoints[_currentTeam.id] = 2;
    } else {
      teamPoints[_currentTeam.id] += 2;
    }
  }

  @override
  void wordIsNotGuessed() {
    if (_roundTeams.isEmpty) {
      _rounds--;
      _roundTeams.addAll(_allTeams);
    }
    if (teamPoints[_currentTeam.id] == null) {
      teamPoints[_currentTeam.id] = 0;
    } else {
      teamPoints[_currentTeam.id] -= 1;
    }
  }

  bool gameIsActive() {
    return _rounds != 0;
  }

}
