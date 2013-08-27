#import "LUAddCardViewController.h"
#import "LURequestHandler.h"

@interface LUAddCardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

@implementation LUAddCardViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Add Card";
}

#pragma mark - Event Methods

- (IBAction)addCard {
  LUCreditCard *creditCard = [[LUCreditCard alloc] init];
  creditCard.number = self.cardNumberTextField.text;
  creditCard.cvv = self.cvvTextField.text;
  creditCard.expirationMonth = @([self.monthTextField.text integerValue]);
  creditCard.expirationYear = @([self.yearTextField.text integerValue]);
  creditCard.postalCode = self.zipCodeTextField.text;

  LUAPIRequest *request = [LUCreditCardRequestFactory requestToCreateCreditCard:creditCard];
  [LURequestHandler performRequest:request
                           success:^(LUCreditCard *savedCreditCard, LUAPIResponse *response) {
                             [self.navigationController popViewControllerAnimated:YES];
                             [SVProgressHUD showSuccessWithStatus:@"Card added!"];
                           }];
}

@end
