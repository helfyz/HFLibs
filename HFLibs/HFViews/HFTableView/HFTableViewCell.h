//
//  HFTableViewCell.h
//  HFKitDemo
//
//  Created by helfy  on 15/8/18.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableCellModel.h"
@interface HFTableViewCell : UITableViewCell
@property (nonatomic,readonly) HFTableCellModel*cellModel;


//重载该函数来设置你的UI
-(void)setupView;

-(void)bindData:(HFTableCellModel *)cellModel;

@end
