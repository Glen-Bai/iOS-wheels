//
//  NSString+GB.m
//  iOSWheels
//
//  Created by baigang on 2020/9/17.
//  Copyright © 2020 baigang. All rights reserved.
//

#import "NSString+GB.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (GB)

+ (BOOL)gb_isEmpty:(NSString *)str {
    if ([str isKindOfClass:NSNull.class]) {
        return YES;
    }
    if (!str) {
        return YES;
    }
    if (str.length == 0) {
        return YES;
    }
    if ([str stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)gb_isNull:(NSString *)str {
    if (!str || [str isKindOfClass:NSNull.class]) {
        return YES;
    }
    return NO;
}

+ (NSString *)gb_md5String:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)gb_md5 {
    return [NSString gb_md5String:self];
}

- (NSString *)gb_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)gb_trimWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)gb_trimNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

- (NSArray *)gb_rangesOfString:(NSString *)searchString {
    if ([NSString gb_isNull:searchString] || searchString.length ==0 || self.length == 0) {
        return nil;
    }
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [self length]);
    NSRange range;
    while ((range = [self rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), self.length - NSMaxRange(range));
    }
    return results;
}

- (NSString *)gb_substringAtRange:(NSRange)range {
    if ([NSString gb_isEmpty:self]) {
        return nil;
    }
    if (range.location > self.length) {
        return nil;
    }
    // To avoid breaking up character sequences such as 👴🏻👮🏽
    range = [self rangeOfComposedCharacterSequencesForRange:range];
    if (range.location + range.length > self.length) {
        return nil;
    }
    return [self substringWithRange:range];
}

- (NSString *)gb_stringByUrlEncoding {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
    return url;
#pragma clang diagnostic pop
}

- (NSURL *)gb_url {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

@end
