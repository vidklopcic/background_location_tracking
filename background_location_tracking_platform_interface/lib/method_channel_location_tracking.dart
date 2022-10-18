import 'dart:async';
import 'package:flutter/services.dart';
import 'background_location_tracking_platform_interface.dart';

class MethodChannelBackgroundLocationTracking extends BackgroundLocationTrackingPlatform {
  static const MethodChannel channel = MethodChannel('plugins.vidklopcic.com/background_location_tracking');

  @override
  Future<List<MotionActivityEvent>?> getPastActivityEventsFromDate(DateTime from) async {
    final result = await channel.invokeListMethod<Map>('getPastActivityEventsFromDate', from.millisecondsSinceEpoch);
    return result?.map((m) => MotionActivityEvent.fromMap(m)).toList();
  }
}
