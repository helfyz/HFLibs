//
//  HFTableSectionObj.h
//  HFKitDemo
//
//  Created by helfy  on 15/9/6.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFTableSectionObj : NSObject

@property (nonatomic,strong) NSMutableArray *cellObjs;


@property (nonatomic,copy)  NSString *title; //默认nil
@property (nonatomic,assign)  float headHeigth;  //默认10
@property (nonatomic,assign)  float footerHeigth;  //默认10


@end
