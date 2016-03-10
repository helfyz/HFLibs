//
//  HFCollectionCellObj.m
//  Project1
//
//  Created by helfy on 16/1/7.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFCollectionCellModel.h"

@implementation HFCollectionCellModel


-(id)init
{
    self = [super init];
    if(self){
        [self setupDefauleValues];
    }
    return self;
}

-(void)setupDefauleValues
{
    self.reuseIdentifier = @"HFCollectionViewCell";
    self.itemSize = CGSizeMake(100, 100);
}

@end
