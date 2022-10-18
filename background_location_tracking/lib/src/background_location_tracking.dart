import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';

class BackgroundLocationTracking {
  static Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from) async {
    return await BackgroundLocationTrackingPlatform.instance.getPastActivityEventsFromDate(from);
  }
}