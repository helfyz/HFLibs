//
//  UIViewController+HFTableView.h
//  Project1
//
//  Created by helfy on 15/12/31.
//  Copyright © 2015年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableView.h"

@class HFTableViewCellModel,HFTableViewFormCellModel,HFTableViewCustomCellModel;
@interface UIViewController (HFTableView)

@property (nonatomic, strong) HFTableView *hft_tableView;


-(void)hft_setupTableViwForTableStyle:(UITableViewStyle)style;
-(void)hft_setupGroupedTableViw;
-(void)hft_setupPlainTableViw;




// 需要覆盖的方法
//
//-(void)tablViewWillReload;
////如果是通过批量设置的方法，需要检测cell点击事件
//-(void)tableViewDidSelectCellObj:(HFCustomTableCellObj *)cellObj;



@end
