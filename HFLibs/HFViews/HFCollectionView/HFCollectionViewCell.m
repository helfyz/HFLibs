//
//  HFCollectionViewCell.m
//  Project1
//
//  Created by helfy on 16/1/7.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFCollectionViewCell.h"

@implementation HFCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

-(void)setupView
{
}

-(void)bindData:(HFCollectionCellModel *)cellObj
{
    _cellObj = cellObj;
}

@end
