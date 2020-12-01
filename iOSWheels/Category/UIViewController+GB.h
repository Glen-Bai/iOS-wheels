//
//  UIViewController+GB.h
//  iOSWheels
//
//  Created by Glen on 2020/12/1.
//  Copyright © 2020 Glen. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GB)

- (void)alertWithTitle:(nullable NSString *)title
                   msg:(nullable NSString *)msg
            okBtnTitle:(nonnull NSString *)okBtnTitle
             okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler
        cancelBtnTitle:(nullable NSString *)cancelBtnTitle
         cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler;

@end

NS_ASSUME_NONNULL_END
