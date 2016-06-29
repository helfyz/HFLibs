//
//  UIView+UserInfo.m
//  DGRouter
//
//  Created by helfy  on 15-3-31.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "UIView+UserInfo.h"
#import <objc/runtime.h>

@implementation UIView (UserInfo)
- (void)setUserInfo:(id )userInfo {
    [self willChangeValueForKey:@"UIViewUserInfo"];
    objc_setAssociatedObject(self, @selector(userInfo),
                             userInfo,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"UIViewUserInfo"];
}

-(id)userInfo
{
    return  objc_getAssociatedObject(self, @selector(userInfo));
}

@end
