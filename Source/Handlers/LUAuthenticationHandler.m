#import "LUAppDelegate.h"
#import "LUAuthenticationHandler.h"

@implementation LUAuthenticationHandler

NSString * const AuthenticationHandlerAccessTokenKey = @"LevelUp Access Token";

#pragma mark - Public Methods

+ (BOOL)isUserAuthenticated {
  LUAccessToken *accessToken = [[LUKeychainAccess standardKeychainAccess] objectForKey:AuthenticationHandlerAccessTokenKey];

  BOOL accessTokenPresent = accessToken.token.length > 0;
  BOOL currentUserIDPresent = [accessToken.userID longValue] > 0;

  if (accessTokenPresent && currentUserIDPresent) {
    [self updateAPIClientWithAccessToken:accessToken];

    return YES;
  } else {
    return NO;
  }
}

+ (void)logInWithAccessToken:(LUAccessToken *)accessToken {
  [self updateAPIClientWithAccessToken:accessToken];
  [[LUKeychainAccess standardKeychainAccess] setObject:accessToken forKey:AuthenticationHandlerAccessTokenKey];

  [[LUAppDelegate sharedAppDelegate] updateRootViewController];
}

+ (void)logOut {
  [self updateAPIClientWithAccessToken:nil];
  [[LUKeychainAccess standardKeychainAccess] setObject:nil forKey:AuthenticationHandlerAccessTokenKey];

  [[LUAppDelegate sharedAppDelegate] updateRootViewController];
}

#pragma mark - Private Methods

+ (void)updateAPIClientWithAccessToken:(LUAccessToken *)accessToken {
  if (accessToken) {
    [LUAPIClient sharedClient].accessToken = accessToken.token;
  } else {
    [LUAPIClient sharedClient].accessToken = nil;
  }
}

@end
