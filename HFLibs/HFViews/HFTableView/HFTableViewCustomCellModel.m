//
//  HFCustomTableCellObj.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/19.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFTableViewCustomCellModel.h"

@implementation HFTableViewCustomCellModel

@synthesize cellIdentifier = _cellIdentifier;

-(void)setupDefauleValues
{
    [super setupDefauleValues];

    self.tablViewCellClassName = @"UITableViewCell";
    _cellIdentifier            = nil;
    self.firstResponder        = NO;
    
}

-(NSString *)cellIdentifier
{
    if(_cellIdentifier)
    {
        return _cellIdentifier;
    }
    
    return self.tablViewCellClassName;
}
-(void)setCellIdentifier:(NSString *)cellIdentifier
{
    _cellIdentifier = cellIdentifier;
}


-(BOOL)isFirstResponder
{
    return self.firstResponder;
}
@end
