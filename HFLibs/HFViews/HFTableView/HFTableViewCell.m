//
//  HFTableViewCell.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/18.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFTableViewCell.h"

@implementation HFTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupView];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setupView
{
    
}

-(void)bindData:(HFTableCellModel *)cellObj
{
    _cellObj = cellObj;
}



@end
