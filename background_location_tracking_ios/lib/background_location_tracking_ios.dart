import 'package:background_location_tracking_platform_interface/method_channel_location_tracking.dart';
import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';

class BackgroundLocationTrackingIOS extends BackgroundLocationTrackingPlatform {
  final MethodChannelBackgroundLocationTracking _methodChannel = MethodChannelBackgroundLocationTracking();

  static void registerWith() {
    BackgroundLocationTrackingPlatform.instance = BackgroundLocationTrackingIOS();
  }

  @override
  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from) {
    return _methodChannel.getPastActivityEventsFromDate(from);
  }
}
