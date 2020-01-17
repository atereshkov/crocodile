import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

class CategoryProvider implements CategoryProviderType {

  @override
  Future<List<CategoryInfoItem>> getAllCategories(BuildContext context) async {
    List<CategoryInfoItem> categories = [];

    String easyName = AppLocalizations.of(context).categoryEasy;
    String easyDescription = AppLocalizations.of(context).categoryEasyDescription;
    CategoryInfoItem easy = CategoryInfoItem(name: easyName, id: 'easy', description: easyDescription);
    categories.add(easy);

    String mediumName = AppLocalizations.of(context).categoryMedium;
    String mediumDescription = AppLocalizations.of(context).categoryMediumDescription;
    CategoryInfoItem medium = CategoryInfoItem(name: mediumName, id: 'medium', description: mediumDescription);
    categories.add(medium);

    String hardName = AppLocalizations.of(context).categoryHard;
    String hardDescription = AppLocalizations.of(context).categoryHardDescription;
    CategoryInfoItem hard = CategoryInfoItem(name: hardName, id: 'hard', description: hardDescription);
    categories.add(hard);

    String abstractName = AppLocalizations.of(context).categoryAbstract;
    String abstractDescription = AppLocalizations.of(context).categoryAbstractDescription;
    CategoryInfoItem abstractCat = CategoryInfoItem(name: abstractName, id: 'abstract', description: abstractDescription);
    categories.add(abstractCat);

    return Future.value(categories);
  }

}