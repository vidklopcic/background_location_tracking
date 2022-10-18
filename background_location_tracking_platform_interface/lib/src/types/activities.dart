import 'package:background_location_tracking_platform_interface/background_location_tracking_platform_interface.dart';

enum MotionActivityType {
  stationary,
  walking,
  running,
  automotive,
  cycling,
  unknown,
}

class MotionActivityEvent {
  final MotionActivityType type;
  final DateTime startDate;
  final int confidence;

  MotionActivityEvent({
    required this.type,
    required this.startDate,
    required this.confidence,
  });

  static MotionActivityEvent fromMap(Map<dynamic, dynamic> m) {
    return MotionActivityEvent(
      type: MotionActivityType.values[m['type']],
      startDate: DateTime.fromMillisecondsSinceEpoch(m['startDate']),
      confidence: m['confidence'],
    );
  }

  @override
  String toString() {
    return 'MotionActivityEvent($type, $startDate, $confidence)';
  }
}
