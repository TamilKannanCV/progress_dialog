#import "ProgressDialogPlugin.h"
#if __has_include(<progress_dialog/progress_dialog-Swift.h>)
#import <progress_dialog/progress_dialog-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "progress_dialog-Swift.h"
#endif

@implementation ProgressDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftProgressDialogPlugin registerWithRegistrar:registrar];
}
@end
