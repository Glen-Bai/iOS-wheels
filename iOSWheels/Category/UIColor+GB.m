//
//  UIColor+GB.m
//  iOSWheels
//
//  Created by baigang on 2020/11/5.
//  Copyright © 2020 baigang. All rights reserved.
//

#import "UIColor+GB.h"

@implementation UIColor (GB)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSInteger)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (NSString *)hexFromUIColor:(UIColor*)color {
    UIColor *fixedColor = color;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        fixedColor = [UIColor colorWithRed:components[0]
                                     green:components[0]
                                      blue:components[0]
                                     alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(fixedColor.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%x%x%x",
            (int)((CGColorGetComponents(fixedColor.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(fixedColor.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(fixedColor.CGColor))[2]*255.0)];
}

@end
