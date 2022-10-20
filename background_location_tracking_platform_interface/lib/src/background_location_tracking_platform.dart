import 'dart:async';

import 'package:background_location_tracking_platform_interface/method_channel_location_tracking.dart';
import 'package:background_location_tracking_platform_interface/src/types/lifecycle.dart';
import 'package:flutter/cupertino.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../background_location_tracking_platform_interface.dart';

abstract class BackgroundLocationTrackingPlatform extends PlatformInterface {
  BackgroundLocationTrackingPlatform() : super(token: _token);

  // streams
  Stream<CommonLifecycleEvent> get lifecycleEvents;

  static final Object _token = Object();

  static BackgroundLocationTrackingPlatform _instance = MethodChannelBackgroundLocationTracking();

  /// The default instance of [BackgroundLocationTrackingPlatform] to use.
  ///
  /// Defaults to [MethodChannelBackgroundLocationTracking].
  static BackgroundLocationTrackingPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [BackgroundLocationTrackingPlatform] when they register themselves.
  static set instance(BackgroundLocationTrackingPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from, DateTime? to);

  Future<bool> isBackground();

  Future init() async {}
}
