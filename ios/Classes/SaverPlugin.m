#import "SaverPlugin.h"
#if __has_include(<saver/saver-Swift.h>)
#import <saver/saver-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "saver-Swift.h"
#endif

@implementation SaverPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSaverPlugin registerWithRegistrar:registrar];
}
@end
