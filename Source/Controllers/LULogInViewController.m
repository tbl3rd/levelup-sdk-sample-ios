#import "LUAppDelegate.h"
#import "LUAuthenticationHandler.h"
#import "LULogInViewController.h"
#import "LURequestHandler.h"

@interface LULogInViewController ()

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;

@end

@implementation LULogInViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Log In";
}

#pragma mark - IBAction Methods

- (IBAction)logIn {
  NSString *email = self.emailTextField.text;
  NSString *password = self.passwordField.text;

  LUAPIRequest *request = [LUAuthenticationRequestFactory requestToLoginWithEmail:email password:password];
  [LURequestHandler performRequest:request
                           success:^(LUAccessToken *accessToken, LUAPIResponse *response) {
                             [LUAuthenticationHandler logInWithAccessToken:accessToken];
                             [SVProgressHUD showSuccessWithStatus:@"Logged in!"];
                           }];
}

@end
