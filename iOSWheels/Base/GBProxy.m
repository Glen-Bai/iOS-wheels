//
//  GBProxy.m
//  iOSWheels
//
//  Created by Glen on 2020/10/26.
//  Copyright © 2020 Glen. All rights reserved.
//

#import "GBProxy.h"

@interface ICSProxy ()
@property (nonatomic, weak) id target;
@end

@implementation ICSProxy

+ (instancetype)proxyWithTarget:(id)target {
    ICSProxy *result = [ICSProxy new];
    result.target = target;
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.target];
}

@end
