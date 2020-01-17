import 'package:flutter/material.dart';

abstract class SinglePlayViewModelType {
  Stream<String> get item;

  void initState(BuildContext context);
  void generateNewWordAction(BuildContext context);
  void dispose();
}