import 'package:flutter/material.dart';
import 'dart:math';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';

class TeamGeneratorService implements TeamGeneratorServiceType {

  RandomNamesProviderType _namesProvider;

  List<TeamNameItem> _seenNames = [];
  List<TeamNameItem> _allNames = [];

  TeamGeneratorService(this._namesProvider);

  @override
  Future<void> start(BuildContext context) async {
    _allNames = await _loadNames(context);
    _seenNames.clear();
  }

  @override
  Future<String> getRandomTeamName(BuildContext context) async {
    if (_allNames.length == 0) {
      _allNames = await _loadNames(context);
      _seenNames.clear();
    }

    final _random = new Random();
    final randomItem = _allNames[_random.nextInt(_allNames.length)];

    _seenNames.add(randomItem);
    _allNames.remove(randomItem);

    String name = randomItem.name;
    return Future.value(name);
  }

  Future<List<TeamNameItem>> _loadNames(BuildContext context) async {
    return _namesProvider.getAllNames(context);
  }

}
