//
//  HFCollectionCellObj.h
//  Project1
//
//  Created by helfy on 16/1/7.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HFCollectionCellObj : NSObject
@property (nonatomic,strong) NSString *reuseIdentifier;
@property (nonatomic,strong) NSString *cellClassName;

@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,strong) id valueData;

@end
