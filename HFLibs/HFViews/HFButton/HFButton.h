//
//  HFButton.h
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HFButtonImageContentMode)
{
    HFButtonImageContentModeBackgroud = 0,  //作为背景
    HFButtonImageContentModeTop,            //图片在文字上面
    HFButtonImageContentModeBottom,
    HFButtonImageContentModeLeft,
    HFButtonImageContentModeRight,
};
@interface HFButton : UIButton

@property (nonatomic,assign) HFButtonImageContentMode imageContentMode;
@property (nonatomic,assign) int space; //图片和title 之间的间隔

@property (nonatomic,assign) UIEdgeInsets contentInsets; //整体内容的缩进

// 基于UIControlStateNormal 的快捷设置
-(void)setImage:(UIImage *)image;  //设置image 状态:UIControlStateNormal
-(void)setImageSize:(CGSize)imagSize;  //
-(void)setImage:(UIImage *)image imagesize:(CGSize)imageSize;

-(void)setTitile:(NSString *)title;
-(void)setTitile:(NSString *)title textColor:(UIColor *)textColor;

-(void)addTarget:(id)target action:(SEL)action;                     // 默认事件:UIControlEventTouchUpInside


//设置默认背景色 & 高亮背景色
-(void)setNormalBgColor:(UIColor *)normalColor highlightedBgColor:(UIColor *)highlightedColor;

@end
