import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'package:crocodile_game/app/service/analytics/remote_analytics_service_type.dart';
import 'package:crocodile_game/app/model/analytics_event_type.dart';

class FirebaseAnalyticsService implements RemoteAnalyticsServiceType {

  final FirebaseAnalytics analytics = FirebaseAnalytics();

  Future<void> sendAnalyticsEvent(AnalyticsEventType event) async {
    if (kReleaseMode) {
      await analytics.logEvent(
        name: event.name,
        parameters: event.parameters,
      );
    }
  }

  void setCurrentScreen(String screenName) {
    if (kReleaseMode) {
      analytics.setCurrentScreen(screenName: screenName);
    }
  }

}