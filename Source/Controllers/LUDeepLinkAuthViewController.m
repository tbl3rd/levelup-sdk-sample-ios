#import "LUAuthenticationHandler.h"
#import "LUDeepLinkAuthViewController.h"
#import "LURequestHandler.h"

@interface LUDeepLinkAuthViewController ()

@property (nonatomic, weak) IBOutlet UILabel *userDetailsLabel;

@end

@implementation LUDeepLinkAuthViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"User Details";

  LUAPIRequest *request = [LUUserRequestFactory requestForCurrentUser];
  [LURequestHandler performRequest:request
                           success:^(LUUser *user, LUAPIResponse *response) {
                             [self showUserDetails:user];
                           }];
}

#pragma mark - Event Methods

- (IBAction)logOutSelected {
  [LUAuthenticationHandler logOut];
  [SVProgressHUD showSuccessWithStatus:@"Logged out"];
}

#pragma mark - Private Methods

- (void)showUserDetails:(LUUser *)user {
  self.userDetailsLabel.text = [NSString stringWithFormat:@"First Name: %@\nLast Name: %@\nEmail: %@\nGender: %@",
                                user.firstName, user.lastName, user.email, [LUUser genderStringForGender:user.gender]];
}

@end
