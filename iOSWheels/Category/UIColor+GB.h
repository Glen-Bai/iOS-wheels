//
//  UIColor+GB.h
//  iOSWheels
//
//  Created by baigang on 2020/11/5.
//  Copyright © 2020 baigang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GB)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (NSString *)hexFromUIColor: (UIColor*) color;

@end

NS_ASSUME_NONNULL_END
