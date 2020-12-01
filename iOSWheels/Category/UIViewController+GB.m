//
//  UIViewController+GB.m
//  iOSWheels
//
//  Created by Glen on 2020/12/1.
//  Copyright © 2020 Glen. All rights reserved.
//

#import "UIViewController+GB.h"
#import "NSString+GB.h"

@implementation UIViewController (GB)

- (void)alertWithTitle:(nullable NSString *)title
                   msg:(nullable NSString *)msg
            okBtnTitle:(nonnull NSString *)okBtnTitle
             okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler
        cancelBtnTitle:(nullable NSString *)cancelBtnTitle
         cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:msg
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okBtnTitle style:UIAlertActionStyleDefault handler:okHandler];
    [alertVC addAction:okAction];
    if (![NSString gb_isEmpty:cancelBtnTitle]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:okBtnTitle style:UIAlertActionStyleDefault handler:cancelHandler];
        [alertVC addAction:cancelAction];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
