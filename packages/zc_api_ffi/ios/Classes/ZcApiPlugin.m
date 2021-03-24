#import "ZcApiPlugin.h"
#if __has_include(<zc_api/zc_api-Swift.h>)
#import <zc_api/zc_api-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zc_api-Swift.h"
#endif

@implementation ZcApiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZcApiPlugin registerWithRegistrar:registrar];
}
@end
