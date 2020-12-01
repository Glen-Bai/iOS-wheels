//
//  UIImage+GB.h
//  iOSWheels
//
//  Created by Glen on 2020/11/30.
//  Copyright © 2020 Glen. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GB)

+ (unsigned char *)getBGRWithImage:(UIImage *)image;
+ (NSData *)imageDataFromBGRData:(unsigned char *)imageData width:(int)width height:(int)height;
+ (UIImage *)imageFromBGRData:(unsigned char *)imageData width:(int)width height:(int)height;

@end

NS_ASSUME_NONNULL_END
