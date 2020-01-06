import 'package:crocodile_game/app/model/analytics_event_type.dart';

abstract class RemoteAnalyticsServiceType {
  Future<void> sendAnalyticsEvent(AnalyticsEventType event);
  void setCurrentScreen(String screenName);
}
