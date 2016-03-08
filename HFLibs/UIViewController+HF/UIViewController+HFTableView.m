//
//  UIViewController+HFTableView.m
//  Project1
//
//  Created by helfy on 15/12/31.
//  Copyright © 2015年 charles. All rights reserved.
//

#import "UIViewController+HFTableView.h"
#import "HFTableView.h"
#import <objc/runtime.h>
@implementation UIViewController (HFTableView)

static char HFTableViewString;
#pragma getter & setter 

- (void)setHft_tableView:(HFTableView *)tableView{
    [self willChangeValueForKey:@"tableView"];
    objc_setAssociatedObject(self, &HFTableViewString,
                             tableView,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"tableView"];
}

-(HFTableView *)hft_tableView
{
    return  objc_getAssociatedObject(self, &HFTableViewString);
}


#pragma setupViews
-(void)hft_setupTableViwForTableStyle:(UITableViewStyle)style
{
    self.hft_tableView  =[[HFTableView alloc] initWithFrame:CGRectZero style:style];
    [self.view addSubview: self.hft_tableView];
    self.hft_tableView .delegate = (id)self;
    self.hft_tableView .dataSource = (id)self;
    self.hft_tableView.frame = self.view.bounds;
    self.hft_tableView.viewController = self;
}
-(void)hft_setupGroupedTableViw
{
    [self hft_setupTableViwForTableStyle:UITableViewStyleGrouped];
}
-(void)hft_setupPlainTableViw
{
    [self hft_setupTableViwForTableStyle:UITableViewStylePlain];
}



@end
