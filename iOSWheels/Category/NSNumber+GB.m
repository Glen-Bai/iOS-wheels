//
//  NSNumber+GB.m
//  iOSWheels
//
//  Created by baigang on 2020/10/15.
//  Copyright © 2020 baigang. All rights reserved.
//

#import "NSNumber+GB.h"
#import "NSObject+GB.h"


@implementation NSNumber (GB)

#pragma mark - 模仿SafeKit
/// https://github.com/JJMM/SafeKit
- (BOOL)gb_isEqualToNumber:(NSNumber *)number {
    if (!number || [number isKindOfClass:NSNull.class]) {
        return [self gb_isEqualToNumber:@0];
    }
    return [self gb_isEqualToNumber:number];
}

- (NSComparisonResult)gb_compare:(NSNumber *)number {
    if (!number || [number isKindOfClass:NSNull.class]) {
        return [self gb_compare:@0];
    }
    return [self gb_compare:number];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gb_swizzleMethod:@selector(isEqualToNumber:) ofClass:@"__NSCFNumber" withNewSel:@selector(gb_isEqualToNumber:)];
        [self gb_swizzleMethod:@selector(compare:) ofClass:@"__NSCFNumber" withNewSel:@selector(gb_compare:)];
    });
}

@end
