import 'package:background_location_tracking_platform_interface/method_channel_location_tracking.dart';
import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';

/// An implementation of [UrlLauncherPlatform] for Android.
class BackgroundLocationTrackingAndroid extends BackgroundLocationTrackingPlatform {
  final MethodChannelBackgroundLocationTracking _methodChannel = MethodChannelBackgroundLocationTracking();

  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith() {
    BackgroundLocationTrackingPlatform.instance = BackgroundLocationTrackingAndroid();
  }

  @override
  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from) {
    throw UnimplementedError();
  }
}
