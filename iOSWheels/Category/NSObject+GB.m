//
//  NSObject+GB.m
//  iOSWheels
//
//  Created by baigang on 2020/10/15.
//  Copyright © 2020 baigang. All rights reserved.
//

#import "NSObject+GB.h"
#import <objc/runtime.h>

@implementation NSObject (GB)

+ (void)gb_swizzleMethod:(SEL)oldSel withNewSel:(SEL)newSel {
    Class clazz = [self class];
    [self gb_swizzleMethod:oldSel ofClass:clazz withNewSel:newSel ofNewClass:clazz];
}

+ (void)gb_swizzleMethod:(SEL)oldSel ofClass:(NSString *)clsName withNewSel:(SEL)newSel {
    if (!clsName || [clsName isKindOfClass:NSNull.class]) {
        return;
    }
    Class newClass = [self class];
    Class oldClass = NSClassFromString(clsName);
    [self gb_swizzleMethod:oldSel ofClass:oldClass withNewSel:newSel ofNewClass:newClass];
}

+ (void)gb_swizzleMethod:(SEL)oldSel ofClass:(Class)oldClass withNewSel:(SEL)newSel ofNewClass:(Class)newClass {
    if (!oldClass || !oldSel || !newClass || !newSel) {
        return;
    }
    Method oldMethod = class_getInstanceMethod(oldClass,oldSel);
    Method newMethod = class_getInstanceMethod(newClass,newSel);
    method_exchangeImplementations(newMethod, oldMethod);
}

@end
