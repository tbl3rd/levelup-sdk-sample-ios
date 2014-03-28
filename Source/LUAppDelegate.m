#import "LUAppDelegate.h"
#import "LUAuthenticationHandler.h"
#import "LULoggedInViewController.h"
#import "LULoggedOutViewController.h"

@implementation LUAppDelegate

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self configureLevelUpSDK];

  [self setupNavigationAndKeyWindow];

  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [LUDeepLinkAuth handleOpenURL:url sourceApplication:sourceApplication];
}

#pragma mark - Public Methods

+ (LUAppDelegate *)sharedAppDelegate {
  return (LUAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)updateRootViewController {
  UIViewController *rootViewController;

  if ([LUAuthenticationHandler isUserAuthenticated]) {
    rootViewController = [[LULoggedInViewController alloc] init];
  } else {
    rootViewController = [[LULoggedOutViewController alloc] init];
  }

  self.navigationController.viewControllers = @[rootViewController];
}

#pragma mark - Private Methods

- (void)configureLevelUpSDK {
  // NOTE: To run this sample, you must enter your App ID and API Key below
  [LUAPIClient setupWithAppID:nil APIKey:nil];
}

- (void)setupNavigationAndKeyWindow {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.navigationController = [[UINavigationController alloc] init];
  self.window.rootViewController = self.navigationController;

  [self updateRootViewController];

  [self.window makeKeyAndVisible];
}

@end
