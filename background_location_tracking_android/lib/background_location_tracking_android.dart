import 'dart:async';

import 'package:background_location_tracking_platform_interface/method_channel_location_tracking.dart';
import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';
import 'package:flutter/services.dart';

class BackgroundLocationTrackingAndroid extends BackgroundLocationTrackingPlatform {
  final MethodChannelBackgroundLocationTracking _methodChannel = MethodChannelBackgroundLocationTracking();

  @override
  Stream<CommonLifecycleEvent> get lifecycleEvents => androidLifecycleEvents
      .map((e) => {
            AndroidLifecycleEvent.onStop: CommonLifecycleEvent.isBackground,
            AndroidLifecycleEvent.onStart: CommonLifecycleEvent.isForeground,
          }[e])
      .where((e) => e != null) as Stream<CommonLifecycleEvent>;

  final StreamController<AndroidLifecycleEvent> _androidLifecycleEvents = StreamController.broadcast();

  Stream<AndroidLifecycleEvent> get androidLifecycleEvents => _androidLifecycleEvents.stream;

  static void registerWith() {
    BackgroundLocationTrackingPlatform.instance = BackgroundLocationTrackingAndroid();
  }

  @override
  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from, DateTime? to) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isBackground() {
    throw UnimplementedError();
  }

  Future _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onAndroidLifecycleEvent':
        _androidLifecycleEvents.add(AndroidLifecycleEvent.values[call.arguments]);
        break;
      default:
        throw UnimplementedError(call.method);
    }
  }
}
