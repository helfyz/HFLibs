//
//  UIView+CGRect.h
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HFCGRect)

@property (nonatomic) CGPoint hf_FrameOrigin;
@property (nonatomic) CGSize hf_FrameSize;

@property (nonatomic) CGFloat hf_OriginX;
@property (nonatomic) CGFloat hf_OriginY;

@property (nonatomic) CGFloat hf_SizeWidth;
@property (nonatomic) CGFloat hf_SizeHeight;
@end
