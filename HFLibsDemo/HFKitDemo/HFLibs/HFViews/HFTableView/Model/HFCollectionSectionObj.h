//
//  HFCollectionSectionObj.h
//  Project1
//
//  Created by helfy on 16/1/6.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HFCollectionSectionObj : NSObject
@property (nonatomic,strong) NSMutableArray *cellObjs;
@property (nonatomic,strong) id valueData;
@property (nonatomic,strong) NSString *reuseIdentifier;
@property (nonatomic,strong) NSString *reusableClassName;

@property (nonatomic,strong) NSString *kind;
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,assign) CGSize headerSize;
@end
