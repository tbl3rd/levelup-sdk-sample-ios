#import "LUAddCardViewController.h"
#import "LUAuthenticationHandler.h"
#import "LULoggedInViewController.h"
#import "LUPayViewController.h"

@implementation LULoggedInViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Select an Action";
}

#pragma mark - IBAction Methods

- (IBAction)addCardSelected {
  LUAddCardViewController *addCardViewController = [[LUAddCardViewController alloc] init];
  [self.navigationController pushViewController:addCardViewController animated:YES];
}

- (IBAction)logOutSelected {
  [LUAuthenticationHandler logOut];
  [SVProgressHUD showSuccessWithStatus:@"Logged out"];
}

- (IBAction)paySelected {
  LUPayViewController *payViewController = [[LUPayViewController alloc] init];
  [self.navigationController pushViewController:payViewController animated:YES];
}

- (IBAction)payWithTipSelected {
  LUPayViewController *payViewController = [[LUPayViewController alloc] initWithTipSelection:YES];
  [self.navigationController pushViewController:payViewController animated:YES];
}

@end
