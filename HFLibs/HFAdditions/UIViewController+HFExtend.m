//
//  UIViewController+HFExtend.m
//  HFKitDemo
//
//  Created by helfy on 16/6/27.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "UIViewController+HFExtend.h"
@implementation UIViewController  (HFExtend)


- (UIViewController *)hf_pushToViewControllerForName:(NSString *)className
{
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    return viewController;
}

@end
