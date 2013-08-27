#import "LULogInViewController.h"
#import "LULoggedOutViewController.h"
#import "LURegisterViewController.h"

@implementation LULoggedOutViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Select an Action";
}

#pragma mark - IBAction Methods

- (IBAction)loginPaySelected {
  LULogInViewController *logInViewController = [[LULogInViewController alloc] init];
  [self.navigationController pushViewController:logInViewController animated:YES];
}

- (IBAction)registerSelected {
  LURegisterViewController *registerViewController = [[LURegisterViewController alloc] init];
  [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
