@interface LURequestHandler : NSObject

+ (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest success:(LUAPISuccessBlock)success;
+ (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest success:(LUAPISuccessBlock)success failure:(LUAPIFailureBlock)failure;

@end
