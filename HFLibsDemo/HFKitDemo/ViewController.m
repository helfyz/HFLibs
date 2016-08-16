//
//  ViewController.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HFTableViewManger.h"
#import "UIViewController+HFExtend.h"
#import "NSNull+HFSafe.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"HFTable";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
    [self setupData];
    
    id null = [NSNull null];
    NSLog(@"null:%lu--%lu",(unsigned long)[null length],(unsigned long)[null count]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTableView {
    [self hft_setupGroupedTableViw];
}
- (void)setupData {
    
    
    void (^configCellBlock)(UITableViewCell *cell, HFTableViewCellModel *cellModel) = ^(UITableViewCell *cell,HFTableViewCellModel *model) {
        cell.textLabel.text = model.cellData;
    };
    
    HFTableViewSectionModel *sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 30;
    sectionObj.headTitle = @"列表模式";
    HFTableViewCellModel*cellModel = [HFTableViewCellModel new];
    cellModel.cellData = @"列表模式";
    [cellModel setConfigCellBlock:configCellBlock];
    __weak ViewController *ws = self;
    
    [cellModel setCellDidSelectBlock:^(UITableViewCell *cell, HFTableViewCellModel *cellModel) {
        [ws hf_pushToViewControllerForName:@"HFDListViewController"];
    }];
    [sectionObj addCellModel:cellModel];
    
    
    
    HFTableViewSectionModel *settingSectionObj = [[HFTableViewSectionModel alloc] init];
    settingSectionObj.headHeigth = 30;
    settingSectionObj.headTitle = @"表单模式";
    cellModel = [HFTableViewCellModel new];
    cellModel.cellData = @"表单模式";
    
    [cellModel setConfigCellBlock:configCellBlock];
    [cellModel setCellDidSelectBlock:^(UITableViewCell *cell, HFTableViewCellModel *cellModel) {
        [ws hf_pushToViewControllerForName:@"HFDFormViewController"];
    }];
    [settingSectionObj addCellModel:cellModel];
    
    [self.hft_tableViewManger setupDataSourceModels:@[sectionObj,settingSectionObj] isAddmore:NO];
    
}

@end
