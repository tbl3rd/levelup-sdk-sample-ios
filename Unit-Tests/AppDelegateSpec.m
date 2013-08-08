#import "AppDelegate.h"

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
  it(@"is a UIApplicationDelegate", ^{
    [[AppDelegate should] conformToProtocol:@protocol(UIApplicationDelegate)];
  });
});

SPEC_END
