import 'package:flutter/widgets.dart';

abstract class MainViewModelType {
  void initState();
  void dispose();

  void singlePlayAction(BuildContext context);
}