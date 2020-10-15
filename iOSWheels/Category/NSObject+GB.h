//
//  NSObject+GB.h
//  iOSWheels
//
//  Created by baigang on 2020/10/15.
//  Copyright © 2020 baigang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GB)

#pragma mark -
#pragma mark - Safe
+ (void)gb_swizzleMethod:(SEL)oldSel
              withNewSel:(SEL)newSel;

+ (void)gb_swizzleMethod:(SEL)oldSel
                 ofClass:(NSString *)clsName
              withNewSel:(SEL)newSel;

+ (void)gb_swizzleMethod:(SEL)oldSel
                 ofClass:(Class)oldClass
              withNewSel:(SEL)newSel
              ofNewClass:(Class)newClass;

@end

NS_ASSUME_NONNULL_END
