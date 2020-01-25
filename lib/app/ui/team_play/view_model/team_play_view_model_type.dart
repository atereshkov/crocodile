import 'package:flutter/material.dart';

abstract class TeamPlayViewModelType {
  Stream<String> get item;

  void initState(BuildContext context);
  void dispose();
}