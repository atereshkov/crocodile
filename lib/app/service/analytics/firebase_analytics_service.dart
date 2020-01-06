import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:crocodile_game/app/service/analytics/remote_analytics_service_type.dart';
import 'package:crocodile_game/app/model/analytics_event_type.dart';

class FirebaseAnalyticsService implements RemoteAnalyticsServiceType {

  final FirebaseAnalytics analytics = FirebaseAnalytics();

  Future<void> sendAnalyticsEvent(AnalyticsEventType event) async {
    await analytics.logEvent(
      name: event.name,
      parameters: event.parameters,
    );
  }

}