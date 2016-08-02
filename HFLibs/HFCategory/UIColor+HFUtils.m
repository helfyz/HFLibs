//
//  UIColor+HFUtils.m
//  HFUtilsDemo
//
//  Created by helfy on 15/9/8.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "UIColor+HFUtils.h"

@implementation  UIColor (HFUtils)

+ (UIColor *)hf_ColorWithHex:(NSInteger)rgbHexValue {
    return [UIColor hf_ColorWithHex:rgbHexValue alpha:1.0];
}

+ (UIColor *)hf_ColorWithHex:(NSInteger)rgbHexValue
                    alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbHexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbHexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
