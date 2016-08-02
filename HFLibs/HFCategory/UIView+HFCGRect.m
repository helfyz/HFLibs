//
//  UIView+CGRect.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "UIView+HFCGRect.h"

@implementation UIView (HFCGRect)

-(CGPoint)hf_FrameOrigin {
    return self.frame.origin;
}
- (void)setHf_FrameOrigin:(CGPoint)hf_frameOrigin {

    CGRect frame = self.frame;
    frame.origin = hf_frameOrigin;
    self.frame   = frame;
}

-(CGSize)hf_FrameSize {
   return self.frame.size;
}
-(void)setHf_FrameSize:(CGSize)frameSize {
    CGRect frame = self.frame;
    frame.size   = frameSize;
    self.frame   = frame;
}

-(CGFloat)hf_OriginX {
    return self.hf_FrameOrigin.x;
}
-(void)setHf_OriginX:(CGFloat)originX {
    CGRect frame   = self.frame;
    CGPoint origin = frame.origin;
    origin.x       = originX;
    frame.origin   = origin;
    self.frame     = frame;
}

-(CGFloat)hf_OriginY {
    return self.hf_FrameOrigin.y;
}
-(void)setHf_OriginY:(CGFloat)originY {
    CGRect frame   = self.frame;
    CGPoint origin = frame.origin;
    origin.y       = originY;
    frame.origin   = origin;
    self.frame     = frame;
}

-(CGFloat)hf_SizeWidth {
     return self.hf_FrameSize.width;
}
-(void)setHf_SizeWidth:(CGFloat)sizeWidth {
    CGRect frame = self.frame;
    CGSize size  = frame.size;
    size.width   = sizeWidth;
    frame.size   = size;
    self.frame   = frame;
}


-(CGFloat)hf_SizeHeight {
    return self.hf_FrameSize.height;
}
-(void)setHf_SizeHeight:(CGFloat)sizeHeight {
    CGRect frame = self.frame;
    CGSize size  = frame.size;
    size.height  = sizeHeight;
    frame.size   = size;
    self.frame   = frame;
}
@end
