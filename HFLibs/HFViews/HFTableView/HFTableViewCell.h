//
//  HFTableViewCell.h
//  HFKitDemo
//
//  Created by helfy  on 15/8/18.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableViewCellModel.h"
@interface HFTableViewCell : UITableViewCell
@property (nonatomic,readonly) HFTableViewCellModel*cellModel;


//重载该函数来设置你的UI
-(void)setupView;

-(void)bindData:(HFTableViewCellModel *)cellModel;

@end
