//
//  UIImage+HFUtils.h
//  HFUtilsDemo
//
//  Created by helfy on 15/9/8.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(HFUtils)

+ (UIImage *)hf_ImageWithColor:(UIColor *)color;
+ (UIImage *)hf_ImageWithColor:(UIColor *)color size:(CGSize)size;

@end
