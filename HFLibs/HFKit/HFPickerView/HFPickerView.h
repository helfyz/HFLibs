//
//  HFPickerView.h
//  HFKitDemo
//
//  Created by helfy on 16/3/18.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, HFPickerViewType) {
    HFPickerViewTypeDate = 0,
    HFPickerViewTypeTime ,
    HFPickerViewTypeDateAndTime ,
    HFPickerViewTypeCustomData ,
    HFPickerViewTypeNone,
};

@interface HFPickerView : UIView

@property (nonatomic, strong) NSArray *dataSourceArrry;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIToolbar *toolBar;
@property (nonatomic, strong) id defaultValue;   //默认值
@property (nonatomic, strong) id minimumDate;    //最小时间  用于时间类picker
@property (nonatomic, strong) id maximumDate;    //最大时间  用于时间类picker
@property(nonatomic,strong) void(^changeBlock)(id chooseValue);

/**
 *  通过类型初始化对象
 *
 *  @param type 类型
 *
 *  @return 实例对象
 */
- (instancetype)initWithType:(HFPickerViewType)type;

- (void)showInView:(UIView *)view;

@end
