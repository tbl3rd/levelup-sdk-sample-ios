@interface LUAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;

+ (LUAppDelegate *)sharedAppDelegate;
- (void)updateRootViewController;

@end
