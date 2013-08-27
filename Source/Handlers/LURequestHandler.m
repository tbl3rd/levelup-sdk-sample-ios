#import "LURequestHandler.h"

@implementation LURequestHandler

#pragma mark - Public Methods

+ (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest success:(LUAPISuccessBlock)success {
  return [self performRequest:apiRequest success:success failure:nil];
}

+ (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest success:(LUAPISuccessBlock)success failure:(LUAPIFailureBlock)failure {
  [SVProgressHUD show];

  return [[LUAPIClient sharedClient] performRequest:apiRequest
                                            success:^(id result, LUAPIResponse *response) {
                                              [SVProgressHUD dismiss];

                                              success(result, response);
                                            }
                                            failure:^(NSError *error) {
                                              if (failure) {
                                                failure(error);
                                              } else {
                                                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                                              }
                                            }];
}

@end
