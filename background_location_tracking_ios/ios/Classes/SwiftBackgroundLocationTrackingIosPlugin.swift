import Flutter
import UIKit

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}



public class SwiftBackgroundLocationTrackingIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.vidklopcic.com/background_location_tracking", binaryMessenger: registrar.messenger())
    let instance = SwiftBackgroundLocationTrackingIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch(call.method) {
      case "getPastActivityEventsFromDate":
          guard let fromMs = call.arguments as? Int64 else {
              result(FlutterError(code: "invalidArgs", message: "Missing from timestamp", details: "Expected 1 Int arg."))
              return
          }
          let from = Date(milliseconds: fromMs);
          var data = [String: Any]()
          data["confidence"] = 1
          data["type"] = 0
          data["startDate"] = 0
          result([data])
          break
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}
