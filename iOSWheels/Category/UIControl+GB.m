//
//  UIControl+GB.m
//  iOSWheels
//
//  Created by Glen on 2020/12/7.
//  Copyright © 2020 Glen. All rights reserved.
//

#import "UIControl+GB.h"
#import <objc/runtime.h>

static double gb_kDefaultInterval = 0.5;

@interface UIControl ()
/// 是否可以点击
@property (nonatomic, assign) BOOL gb_isIgnoreClick;
/// 上次按钮响应的方法名
@property (nonatomic, strong) NSString *gb_oldSELName;
@end

@implementation UIControl (GB)

+ (void)gb_exchangeClickMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //  获得方法选择器
        SEL originalSel = @selector(sendAction:to:forEvent:);
        SEL newSel = @selector(gb_sendClickIntervalAction:to:forEvent:);
        //获得方法
        Method originalMethod = class_getInstanceMethod(self , originalSel);
        Method newMethod = class_getInstanceMethod(self , newSel);
        
        //   如果发现方法已经存在，返回NO；也可以用来做检查用,这里是为了避免源方法没有存在的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
        BOOL isAddNewMethod = class_addMethod(self, originalSel, method_getImplementation(newMethod), "v@:");
        if (isAddNewMethod) {
            class_replaceMethod(self, newSel, method_getImplementation(originalMethod), "v@:");
        } else {
            method_exchangeImplementations(originalMethod, newMethod);
        }
    });
}

- (void)gb_sendClickIntervalAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[UIButton class]] && !self.gb_ignoreClickInterval) {
        NSLog(@"+++++++%s",__FUNCTION__);
        if (self.gb_clickInterval <= 0) {
            self.gb_clickInterval = gb_kDefaultInterval;
        };
        
        NSString *currentSELName = NSStringFromSelector(action);
        if (self.gb_isIgnoreClick && [self.gb_oldSELName isEqualToString:currentSELName]) {
            return;
        }
        
        if (self.gb_clickInterval > 0) {
            self.gb_isIgnoreClick = YES;
            self.gb_oldSELName = currentSELName;
            [self performSelector:@selector(gb_ignoreClickState:)
                       withObject:@(NO)
                       afterDelay:self.gb_clickInterval];
        }
    }
    [self gb_sendClickIntervalAction:action to:target forEvent:event];
}

- (void)gb_ignoreClickState:(NSNumber *)ignoreClickState {
    self.gb_isIgnoreClick = ignoreClickState.boolValue;
    self.gb_oldSELName = @"";
}

- (NSTimeInterval)gb_clickInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setGb_clickInterval:(NSTimeInterval)clickInterval {
    objc_setAssociatedObject(self, @selector(gb_clickInterval), @(clickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)gb_isIgnoreClick {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setGb_isIgnoreClick:(BOOL)isIgnoreClick {
    objc_setAssociatedObject(self, @selector(gb_isIgnoreClick), @(isIgnoreClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)gb_ignoreClickInterval {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setGb_IgnoreClickInterval:(BOOL)ignoreClickInterval {
    objc_setAssociatedObject(self, @selector(gb_ignoreClickInterval), @(ignoreClickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)gb_oldSELName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGb_oldSELName:(NSString *)oldSELName {
    objc_setAssociatedObject(self, @selector(gb_oldSELName), oldSELName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
