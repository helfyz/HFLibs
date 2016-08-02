//
//  UIViewController+HFTableView.m
//  Project1
//
//  Created by helfy on 15/12/31.
//  Copyright © 2015年 charles. All rights reserved.
//

#import "UIViewController+HFTableViewManger.h"
#import <objc/runtime.h>
@implementation UIViewController (HFTableViewManger)

#pragma getter & setter

- (void)setHft_tableViewManger:(HFTableViewManger *)hft_tableViewManger {
    objc_setAssociatedObject(self, @selector(hft_tableViewManger),
                             hft_tableViewManger,
                             OBJC_ASSOCIATION_RETAIN);
}

- (HFTableViewManger *)hft_tableViewManger {
    return  objc_getAssociatedObject(self, @selector(hft_tableViewManger));
}

#pragma setupViews

- (void)hft_setupTableViwForTableStyle:(UITableViewStyle)style {
    
    self.hft_tableViewManger  = [HFTableViewManger mangerForTableViewStyle:style];
    self.hft_tableViewManger.delegate = (id)self;
    self.hft_tableViewManger.dataSource = (id)self;
    
    [self.view addSubview:self.hft_tableViewManger.tableView];
    self.hft_tableViewManger.tableView.frame = self.view.bounds;
}

- (void)hft_setupGroupedTableViw {
    [self hft_setupTableViwForTableStyle:UITableViewStyleGrouped];
}
- (void)hft_setupPlainTableViw {
    [self hft_setupTableViwForTableStyle:UITableViewStylePlain];
}

@end
