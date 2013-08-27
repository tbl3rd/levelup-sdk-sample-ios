@interface LUAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (LUAppDelegate *)sharedAppDelegate;
- (void)updateRootViewController;

@end
