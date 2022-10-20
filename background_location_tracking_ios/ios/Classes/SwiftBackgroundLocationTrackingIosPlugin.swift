import Flutter
import UIKit
import CoreMotion

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}



public class SwiftBackgroundLocationTrackingIosPlugin: NSObject, FlutterPlugin {
    var channel: FlutterMethodChannel
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "plugins.vidklopcic.com/background_location_tracking", binaryMessenger: registrar.messenger())
        let instance = SwiftBackgroundLocationTrackingIosPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance);
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "getPastActivityEventsFromDate":
            guard let args = call.arguments as? Array<Any> else {
                result(FlutterError(code: "invalidArgs", message: "Args must be [Int64, Int64?].", details: "Expected 2 args."))
                return
            }
            
            if (args.count != 2) {
                result(FlutterError(code: "invalidArgs", message: "Argument count must be 2.", details: "Expected 2 args."))
                return
            }
            
            guard let fromMs = args[0] as? Int64 else {
                result(FlutterError(code: "invalidArgs", message: "Missing from timestamp", details: "Expected 1 Int arg."))
                return
            }
            let from = Date(milliseconds: fromMs);
            
            let toMs = args[1] as? Int64
            var to = Date();
            if (toMs != nil) {
                to = Date(milliseconds: toMs!);
            }
            SwiftBackgroundLocationTrackingIosPlugin.getPastActivityEventsFromDate(result, from, to);
            break
        case "isBackground":
            result(UIApplication.shared.applicationState == .background)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func getPastActivityEventsFromDate(_ result: @escaping FlutterResult, _ from: Date, _ to: Date) {
         if (CMMotionActivityManager.isActivityAvailable()) {
            let motionActivityManager = CMMotionActivityManager()
            
            //check activity for past half hour if any was automotive
            motionActivityManager.queryActivityStarting(from: from, to: to, to: OperationQueue.main) { (activities, error) in
                var data = []
                if (activities != nil) {
                    for (_, activity) in activities!.enumerated() {
                        var item = [String: Any]()
                        item["confidence"] = [
                            CMMotionActivityConfidence.low: 25,
                            CMMotionActivityConfidence.medium: 50,
                            CMMotionActivityConfidence.high: 75
                        ][activity.confidence]
                        if (activity.stationary) {
                            item["type"] = 0
                        } else if (activity.walking) {
                            item["type"] = 1
                        } else if (activity.running) {
                            item["type"] = 2
                        } else if (activity.automotive) {
                            item["type"] = 3
                        } else if (activity.cycling) {
                            item["type"] = 4
                        } else {
                            // unknown
                            item["type"] = 5
                        }
                        item["startDate"] = activity.startDate.millisecondsSince1970
                        data.append(item)
                    }
                }
                result(data)
            }
         } else {
             result(nil)
         }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        self.channel.invokeMethod("onIosLifecycleEvent", arguments: 0)
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        self.channel.invokeMethod("onIosLifecycleEvent", arguments: 1)
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        self.channel.invokeMethod("onIosLifecycleEvent", arguments: 2)
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
        self.channel.invokeMethod("onIosLifecycleEvent", arguments: 3)
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
        self.channel.invokeMethod("onIosLifecycleEvent", arguments: 4)
    }
}
