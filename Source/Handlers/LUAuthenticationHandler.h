@interface LUAuthenticationHandler : NSObject

+ (BOOL)isUserAuthenticated;
+ (void)logInWithAccessToken:(LUAccessToken *)accessToken;
+ (void)logOut;

@end
