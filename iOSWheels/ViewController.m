//
//  ViewController.m
//  iOSWheels
//
//  Created by baigang on 2020/9/17.
//  Copyright © 2020 baigang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNumber *hah = @1;
    NSLog(@"%d",[hah compare:@200] == NSOrderedSame);
    NSLog(@"按时到");
    
    gb_dispatch_main_async_safe(^{
        NSLog(@"gb_dispatch_main_async_safe");
    });
}


@end
