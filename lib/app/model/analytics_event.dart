import 'package:crocodile_game/app/model/analytics_event_type.dart';

class RemoteAnalyticsEvent implements AnalyticsEventType {
  String name;
  Map<String, dynamic> parameters;

  RemoteAnalyticsEvent({this.name, this.parameters});
}