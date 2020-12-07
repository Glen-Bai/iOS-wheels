//
//  UIControl+GB.h
//  iOSWheels
//
//  Created by Glen on 2020/12/7.
//  Copyright © 2020 Glen. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (GB)

#pragma mark -
#pragma mark - 禁止按钮连点
//https://juejin.cn/post/6899057632716750855
/// 点击事件响应的时间间隔，不设置或者大于 0 时为默认时间间隔 0.5s
@property (nonatomic, assign) NSTimeInterval gb_clickInterval;
/// 是否忽略响应的时间间隔
@property (nonatomic, assign) BOOL gb_ignoreClickInterval;
+ (void)gb_exchangeClickMethod;

@end

NS_ASSUME_NONNULL_END
