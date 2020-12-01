//
//  UIImage+GB.m
//  iOSWheels
//
//  Created by Glen on 2020/11/30.
//  Copyright © 2020 Glen. All rights reserved.
//

#import "UIImage+GB.h"
#import <CoreServices/UTCoreTypes.h>

@implementation UIImage (GB)

+ (unsigned char *)getBGRWithImage:(UIImage *)image {
    int RGBA = 4;
    int BGR  = 3;
    CGImageRef imageRef = [image CGImage];
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *) malloc(width * height * sizeof(unsigned char) * RGBA);
    NSUInteger bytesPerPixel = RGBA;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent,
                                                 bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    unsigned char * bgrRawData = (unsigned char *)malloc(width * height * 3 * sizeof(unsigned char));
    for (int i = 0; i < width * height; i ++) {
        NSUInteger byteIndex = i * RGBA;
        NSUInteger newByteIndex = i * BGR;
        CGFloat red    = rawData[byteIndex + 0];
        CGFloat green  = rawData[byteIndex + 1];
        CGFloat blue   = rawData[byteIndex + 2];
        bgrRawData[newByteIndex + 0] = blue;
        bgrRawData[newByteIndex + 1] = green;
        bgrRawData[newByteIndex + 2] = red;
    }
    free(rawData);
    return bgrRawData;
}

+ (NSData *)imageDataFromBGRData:(unsigned char *)imageData width:(int)width height:(int)height {
    int offset = 3;
    int pixelCount = width * height;
    uint8_t* rgb = (uint8_t*)malloc(pixelCount * offset);
    int m = 0;
    int n = 0;
    /** 移除掉Alpha */
    for(int i=0; i<pixelCount; i++){
        rgb[m++] = imageData[n+2];
        rgb[m++] = imageData[n+1];
        rgb[m++] = imageData[n+0];
        n+=offset;
    }
    NSData *data = [[NSData alloc] initWithBytes:rgb length:width*height*offset];
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(width, height, 8, 8*3, width*3, rgbSpace,
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,
                                        provider, NULL, false, kCGRenderingIntentDefault);
//    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CFMutableDataRef newImageData = CFDataCreateMutable(NULL, 0);
    // 如果是kUTTypePNG 会和上面转UIIMage 再转data得到的length一样
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(newImageData, kUTTypeJPEG, 1, NULL);
    CGImageDestinationAddImage(destination, imageRef, nil);
    if(!CGImageDestinationFinalize(destination)) {
        free(rgb);
        CGImageRelease(imageRef);
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(rgbSpace);
        return nil;
    }
    NSData *newImage = (__bridge  NSData *)newImageData;
    free(rgb);
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgbSpace);
    return newImage;
}

+ (UIImage *)imageFromBGRData:(unsigned char *)imageData width:(int)width height:(int)height {
    int pixelCount = width * height;
    uint8_t* rgb = (uint8_t*)malloc(pixelCount * 3);
    int m = 0;
    int n = 0;
    /** 移除掉Alpha */
    for(int i=0; i<pixelCount; i++){
        rgb[m++] = imageData[n+2];
        rgb[m++] = imageData[n+1];
        rgb[m++] = imageData[n+0];
        n+=3;
    }
    NSData *data = [[NSData alloc] initWithBytes:rgb length:width*height*3];
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(width, height, 8, 8*3, width*3, rgbSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    free(rgb);
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgbSpace);
    
    return image;
}

@end
