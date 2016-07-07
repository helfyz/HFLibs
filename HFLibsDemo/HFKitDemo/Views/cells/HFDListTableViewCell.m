//
//  HFDListTableViewCell.m
//  HFKitDemo
//
//  Created by helfy on 16/3/17.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDListTableViewCell.h"

@implementation HFDListTableViewCell

-(void)setupView
{
    //设置view
    self.contentLabel.font = [UIFont systemFontOfSize:14];

}
-(void)bindData:(HFTableViewCellModel *)cellModel
{
    //根据 valueData 绑定数据
    [super bindData:cellModel];
    
    NSString *contentText = cellModel.cellData;
    self.contentLabel.text = contentText;
}

@end
