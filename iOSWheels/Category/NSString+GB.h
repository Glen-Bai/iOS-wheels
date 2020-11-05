//
//  NSString+GB.h
//  iOSWheels
//
//  Created by Glen on 2020/9/17.
//  Copyright © 2020 Glen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GB)

/// nil/empty
+ (BOOL)gb_isEmpty:(NSString *)str;
+ (BOOL)gb_isNull:(NSString *)str;

/// encrypt
+ (NSString *)gb_md5String:(NSString *)str;
- (NSString *)gb_md5;

///edit
- (NSString *)gb_trim;
- (NSString *)gb_trimWhitespace;
- (NSString *)gb_trimNewline;
- (NSArray *)gb_rangesOfString:(NSString *)searchString;
- (NSString *)gb_substringAtRange:(NSRange)range;

///network
- (NSString *)gb_stringByUrlEncoding;
- (NSURL *)gb_url;

@end

NS_ASSUME_NONNULL_END
