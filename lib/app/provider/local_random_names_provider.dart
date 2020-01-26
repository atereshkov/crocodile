import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';

class LocalRandomNamesProvider implements RandomNamesProviderType {

  @override
  Future<List<TeamNameItem>> getAllNames(BuildContext context) async {
    var jsonNames = await _getJsonNames(context);

    List<TeamNameItem> items = [];
    for (var model in jsonNames) {
      TeamNameItem item = TeamNameItem.fromMap(model);
      items.add(item);
    }

    return Future.value(items);
  }

  Future<dynamic> _getJsonNames(BuildContext context) async {
    String lang = AppLocalizations.of(context).getCurrentLangCode;
    String resourceFile = 'resources/team_names_$lang.json';
    String jsonData = await DefaultAssetBundle.of(context).loadString(resourceFile);

    var data = json.decode(jsonData);
    return data["names"];
  }

}
