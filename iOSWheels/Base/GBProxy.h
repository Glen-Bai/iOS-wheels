//
//  GBProxy.h
//  iOSWheels
//
//  Created by baigang on 2020/10/26.
//  Copyright © 2020 baigang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICSProxy : NSObject

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
