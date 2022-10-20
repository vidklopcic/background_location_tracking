import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';

class BackgroundLocationTracking {
  static Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from, {DateTime? to}) async {
    return await BackgroundLocationTrackingPlatform.instance.getPastActivityEventsFromDate(from, to);
  }

  static Future<bool> isBackground() async {
    return await BackgroundLocationTrackingPlatform.instance.isBackground();
  }

  static Stream<CommonLifecycleEvent> get lifecycleEvents =>
      BackgroundLocationTrackingPlatform.instance.lifecycleEvents;

  static Future init() {
    return BackgroundLocationTrackingPlatform.instance.init();
  }
}
