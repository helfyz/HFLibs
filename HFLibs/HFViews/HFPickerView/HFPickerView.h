//
//  HFPickerView.h
//  HFKitDemo
//
//  Created by helfy on 16/3/18.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum{
    HFPickerViewTypeDate =0,
    HFPickerViewTypeTime ,
    HFPickerViewTypeDateAndTime ,
    HFPickerViewTypeCustomData ,
    HFPickerViewTypeNone,
    
}HFPickerViewType;


@interface HFPickerView : UIView

-(id)initWithType:(HFPickerViewType)type;
@property (nonatomic,strong) NSArray *dataSourceArrry;

@property(nonatomic,strong,readonly) UIView *contentView;
@property(nonatomic,strong,readonly) UIToolbar *toolBar;

@property (nonatomic,strong) id defaultValue;   //默认值

@property (nonatomic,strong) id minimumDate;    //最小时间  用于时间类picker
@property (nonatomic,strong) id maximumDate;    //最大时间  用于时间类picker

@property(nonatomic,strong) void(^changeBlock)(id chooseValue);

-(void)showInView:(UIView *)view;

@end
