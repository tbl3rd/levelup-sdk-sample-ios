#import "LUAuthenticationHandler.h"
#import "LURegisterViewController.h"
#import "LURequestHandler.h"

@interface LURegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LURegisterViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Register";
}

- (IBAction)signUp {
  LUUser *user = [[LUUser alloc] init];
  user.firstName = self.firstNameTextField.text;
  user.lastName = self.lastNameTextField.text;
  user.email = self.emailTextField.text;
  user.password = self.passwordTextField.text;
  user.termsAccepted = YES;

  LUAPIRequest *request = [LUUserRequestFactory requestToCreateUser:user];
  [LURequestHandler performRequest:request
                           success:^(LUUser *createdUser, LUAPIResponse *response) {
                             [self logInWithUser:user];
                           }];
}

#pragma mark - Private Methods

- (void)logInWithUser:(LUUser *)user {
  [LURequestHandler performRequest:[LUAuthenticationRequestFactory requestToLoginWithEmail:user.email password:user.password]
                           success:^(LUAccessToken *accessToken, LUAPIResponse *response) {
                             [LUAuthenticationHandler logInWithAccessToken:accessToken];
                             [SVProgressHUD showSuccessWithStatus:@"User created!"];
                           }];
}

@end
