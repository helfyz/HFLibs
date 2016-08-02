//
//  NSObject+HFUtils.m
//  HFUtilsDemo
//
//  Created by helfy on 15/9/8.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "NSObject+HFUtils.h"

@implementation NSObject (HFUtils)

- (BOOL)hf_IsNull {
    if(!self || [[NSNull null] isEqual:self] || [self isEqual:Nil] || [self isEqual:NULL]) {
        return YES;
    }
    return NO;
}
@end
