#import "LUDeepLinkAuthViewController.h"
#import "LULogInViewController.h"
#import "LULoggedOutViewController.h"
#import "LURegisterViewController.h"

@implementation LULoggedOutViewController

#pragma mark - Object Lifecycle Methods

- (id)init {
  self = [super init];
  if (!self) return nil;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(deepLinkAuthFailed:)
                                               name:LUDeepLinkAuthErrorNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(deepLinkAuthSucceeded:)
                                               name:LUDeepLinkAuthSuccessNotification
                                             object:nil];

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Select an Action";
}

#pragma mark - IBAction Methods

- (IBAction)deepLinkAuthSelected {
  [LUDeepLinkAuth authorizeWithPermissions:@[@"read_user_basic_info"] returnURLScheme:@"levelup-sdk-sample"];
}

- (IBAction)passwordLoginSelected {
  LULogInViewController *logInViewController = [[LULogInViewController alloc] init];
  [self.navigationController pushViewController:logInViewController animated:YES];
}

- (IBAction)registerSelected {
  LURegisterViewController *registerViewController = [[LURegisterViewController alloc] init];
  [self.navigationController pushViewController:registerViewController animated:YES];
}

#pragma mark - Private Methods

- (void)deepLinkAuthFailed:(NSNotification *)notification {
  NSError *error = notification.userInfo[LUDeepLinkAuthNotificationErrorKey];

  [[[UIAlertView alloc] initWithTitle:@"Deep Link Auth Error"
                              message:[error localizedDescription]
                             delegate:nil
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil] show];
}

- (void)deepLinkAuthSucceeded:(NSNotification *)notification {
  NSString *accessToken = notification.userInfo[LUDeepLinkAuthNotificationAccessTokenKey];
  [LUAPIClient sharedClient].accessToken = accessToken;
  self.navigationController.viewControllers = @[[[LUDeepLinkAuthViewController alloc] init]];
}

@end
