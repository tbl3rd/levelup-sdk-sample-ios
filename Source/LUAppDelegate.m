#import "LUAppDelegate.h"
#import "LUAuthenticationHandler.h"
#import "LULoggedInViewController.h"
#import "LULoggedOutViewController.h"

@interface LUAppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation LUAppDelegate

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self configureLevelUpSDK];

  [self setupNavigationAndKeyWindow];

  return YES;
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
  [LUAPIClient setupWithAppID:nil APIKey:nil developmentMode:YES];
}

- (void)setupNavigationAndKeyWindow {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.navigationController = [[UINavigationController alloc] init];
  self.window.rootViewController = self.navigationController;

  [self updateRootViewController];

  [self.window makeKeyAndVisible];
}

@end
