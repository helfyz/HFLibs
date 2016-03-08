//
//  HFTableSectionObj.m
//  HFKitDemo
//
//  Created by helfy  on 15/9/6.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFTableSectionObj.h"

@implementation HFTableSectionObj

-(id)init
{
    self = [super init];
    if(self)
    {
        self.cellObjs = [NSMutableArray array];
        self.headHeigth = 10;
        self.footerHeigth = 10;
    }
    return self;
}
@end
