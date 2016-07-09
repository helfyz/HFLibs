//
//  UIColor+HFUtils.h
//  HFUtilsDemo
//
//  Created by helfy on 15/9/8.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HFUtils)


#pragma mark Hex Color
+ (UIColor *) colorWithHex:(NSInteger)rgbHexValue;
+ (UIColor *) colorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha;

@end
