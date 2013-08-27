#import "LUPayViewController.h"
#import "LURequestHandler.h"

@interface LUPayViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *QRCodeImageView;
@property (nonatomic, assign) NSInteger tip;
@property (nonatomic, weak) IBOutlet UIView *tipSection;
@property (nonatomic, assign) BOOL tipSelection;
@property (nonatomic, strong) LUPaymentToken *paymentToken;

@end

@implementation LUPayViewController

#pragma mark - Creation Methods

- (id)init {
  return [self initWithTipSelection:NO];
}

- (id)initWithTipSelection:(BOOL)tipSelection {
  self = [super init];
  if (!self) return nil;

  _tip = 0;
  _tipSelection = tipSelection;

  return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.tipSelection) {
    self.title = @"Pay with Tip";
  } else {
    self.title = @"Pay";
  }

  self.tipSection.hidden = !self.tipSelection;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  LUAPIRequest *request = [LUPaymentTokenRequestFactory requestForPaymentToken];
  [LURequestHandler performRequest:request
                           success:^(LUPaymentToken *paymentToken, LUAPIResponse *response) {
                             self.paymentToken = paymentToken;
                             [self refreshQRCode];
                           }
                           failure:^(NSError *error) {
                             if ([error.domain isEqualToString:LUAPIErrorDomain] && error.code == LUAPIErrorNotFound) {
                               [SVProgressHUD showErrorWithStatus:@"Please add a credit/debit card to pay."];
                             } else {
                               [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                             }
                           }];
}

#pragma mark - Event Methods

- (IBAction)tipSelectionChanged:(UISegmentedControl *)tipSelector {
  self.tip = tipSelector.selectedSegmentIndex * 5;
  [self refreshQRCode];
}

#pragma mark - Private Methods

- (void)refreshQRCode {
  if (self.paymentToken.data.length > 0) {
    self.QRCodeImageView.image = [LUQRCodeGenerator QRCodeFromString:self.paymentToken.data withTipPercentage:self.tip];
  }
}

@end
