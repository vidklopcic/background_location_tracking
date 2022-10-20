import 'dart:async';

import 'package:background_location_tracking_ios/types/lifecycle.dart';
import 'package:background_location_tracking_platform_interface/method_channel_location_tracking.dart';
import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';
import 'package:flutter/services.dart';

class BackgroundLocationTrackingIOS extends BackgroundLocationTrackingPlatform {
  final MethodChannelBackgroundLocationTracking _methodChannel = MethodChannelBackgroundLocationTracking();

  @override
  Stream<CommonLifecycleEvent> get lifecycleEvents => iosLifecycleEvents
      .map((e) => {
            IOSLifecycleEvent.applicationDidEnterBackground: CommonLifecycleEvent.isBackground,
            IOSLifecycleEvent.applicationWillEnterForeground: CommonLifecycleEvent.isForeground,
          }[e])
      .where((e) => e != null)
      .map((e) => e!);

  final StreamController<IOSLifecycleEvent> _iosLifecycleEvents = StreamController.broadcast();

  Stream<IOSLifecycleEvent> get iosLifecycleEvents => _iosLifecycleEvents.stream;

  static void registerWith() {
    BackgroundLocationTrackingPlatform.instance = BackgroundLocationTrackingIOS();
  }

  @override
  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from, DateTime? to) {
    return _methodChannel.getPastActivityEventsFromDate(from, to);
  }

  @override
  Future<bool> isBackground() {
    return _methodChannel.isBackground();
  }

  Future _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onIosLifecycleEvent':
        _iosLifecycleEvents.add(IOSLifecycleEvent.values[call.arguments]);
        break;
      default:
        throw UnimplementedError(call.method);
    }
  }

  @override
  Future init() async {
    MethodChannelBackgroundLocationTracking.channel.setMethodCallHandler(_onMethodCall);
  }
}
