//
//  HFCollectionReusableView.m
//  Project1
//
//  Created by helfy on 16/1/7.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFCollectionReusableView.h"

@implementation HFCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

//重载该函数来设置你的UI
-(void)setupView
{

}

-(void)bindData:(HFCollectionSectionObj *)sectionObj
{
    _sectionObj = sectionObj;
}

@end
