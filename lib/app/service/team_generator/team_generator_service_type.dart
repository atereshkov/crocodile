import 'package:flutter/widgets.dart';

abstract class TeamGeneratorServiceType {
  Future<void> start(BuildContext context);
  Future<String> getRandomTeamName(BuildContext context, List<String> exclude);
}
