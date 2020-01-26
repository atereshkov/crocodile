import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class RandomNamesProviderType {
  Future<List<TeamNameItem>> getAllNames(BuildContext context);
}
