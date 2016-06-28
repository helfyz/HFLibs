//
//  HFDChooseTableViewCell.m
//  HFKitDemo
//
//  Created by helfy on 16/6/28.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDChooseTableViewCell.h"
#import "HFTableViewCellFormModel.h"
@implementation HFDChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // Initialization code
}

-(void)bindData:(HFTableViewCellFormModel *)cellModel
{
    //根据 valueData 绑定数据
    
    self.titleLabel.text = cellModel.cellData;
    self.valueLable.text = cellModel.cellFormValue;
}



@end
