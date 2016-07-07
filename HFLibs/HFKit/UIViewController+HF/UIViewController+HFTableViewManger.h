//
//  UIViewController+HFTableView.h
//  Project1
//
//  Created by helfy on 15/12/31.
//  Copyright © 2015年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableViewManger.h"
#import "HFTableViewCell.h"
#import "HFTableViewCellModel.h"
#import "HFTableViewSectionModel.h"
@class HFTableViewCellModel,HFTableViewFormCellModel,HFTableViewCustomCellModel;

@interface UIViewController (HFTableViewManger)

@property (nonatomic, strong) HFTableViewManger *hft_tableViewManger;

- (void)hft_setupGroupedTableViw;
- (void)hft_setupPlainTableViw;

@end
