//
//  UIView+UserInfo.m
//  DGRouter
//
//  Created by helfy  on 15-3-31.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "UIView+HFUserInfo.h"
#import <objc/runtime.h>
static char UIViewUserInfo;

@implementation UIView (HFUserInfo)

- (void)setHf_UserInfo:(id )userInfo {
    objc_setAssociatedObject(self, &UIViewUserInfo,
                             userInfo,
                             OBJC_ASSOCIATION_RETAIN);
}

- (id)hf_UserInfo
{
 return  objc_getAssociatedObject(self, &UIViewUserInfo);

}

@end
