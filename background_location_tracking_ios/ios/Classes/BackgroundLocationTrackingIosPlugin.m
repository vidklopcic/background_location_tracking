#import "BackgroundLocationTrackingIosPlugin.h"
#if __has_include(<background_location_tracking_ios/background_location_tracking_ios-Swift.h>)
#import <background_location_tracking_ios/background_location_tracking_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "background_location_tracking_ios-Swift.h"
#endif

@implementation BackgroundLocationTrackingIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBackgroundLocationTrackingIosPlugin registerWithRegistrar:registrar];
}
@end
