//
//  HFCollectionSectionObj.m
//  Project1
//
//  Created by helfy on 16/1/6.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFCollectionSectionObj.h"

@implementation HFCollectionSectionObj
-(id)init
{
    self = [super init];
    if(self)
    {
        self.cellObjs = [NSMutableArray array];
        self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.kind = UICollectionElementKindSectionHeader;
//        self.reuseIdentifier = @"HFCollectionReusableView";
        self.headerSize = CGSizeZero;
    }
    return self;
}

-(NSString *)reuseIdentifier
{
    if(_reuseIdentifier == nil)
    {
       return  self.reusableClassName;
    }
    
    return _reuseIdentifier;
}
@end
