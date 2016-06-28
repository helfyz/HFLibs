//
//  HFDCustomInputTableViewCell.m
//  HFKitDemo
//
//  Created by helfy on 16/3/21.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDCustomInputTableViewCell.h"
#import "HFTableViewCellFormModel.h"
@implementation HFDCustomInputTableViewCell

-(void)awakeFromNib
{
     [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputTextFiled.delegate = self;
}

-(void)bindData:(HFTableViewCellFormModel *)cellModel
{
    self.cellModel = cellModel;
    //根据 valueData 绑定数据
    self.titleLbale.text = cellModel.cellData;
    self.inputTextFiled.text = cellModel.cellFormValue;
}



-(BOOL)isFirstResponder
{
    return [self.inputTextFiled isFirstResponder];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.cellModel.cellFormValue = textField.text;
}
@end
