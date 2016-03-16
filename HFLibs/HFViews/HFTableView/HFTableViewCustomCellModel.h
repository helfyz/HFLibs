//
//  HFCustomTableCellObj.h
//  HFKitDemo
//
//  Created by helfy  on 15/8/19.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFTableViewCellModel.h"

@interface HFTableViewCustomCellModel: HFTableViewCellModel

@property (nonatomic,assign) BOOL firstResponder;   //custom cell 需用户自己控制是否是输入状态。遍历的话会太麻烦

-(void)setCellIdentifier:(NSString *)cellIdentifier;


@end
