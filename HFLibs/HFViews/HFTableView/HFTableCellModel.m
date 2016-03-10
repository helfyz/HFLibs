//
//  HFTableCellObj.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/18.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFTableCellModel.h"

@implementation HFTableCellModel


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
    self.accessoryType         = UITableViewCellAccessoryNone;
    self.selectionStyle        = UITableViewCellSelectionStyleDefault;
    self.tablViewCellClassName = @"UITableViewCell";
    self.isStaticObj           = NO;

    self.useXib                = NO;
}


- (BOOL)isFirstResponder
{
    return NO;
}

@end