//
//  HFDSettingViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/3/17.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDSettingViewController.h"
#import "UIViewController+HFTableView.h"

@interface HFDSettingViewController ()

@end

@implementation HFDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTableView
{
    [self hft_setupGroupedTableViw];
}

-(void)setupData
{
    
    NSMutableArray *dataSource = [NSMutableArray array];
    //section 1
    HFTableViewSectionModel *sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 40;
    sectionObj.headTitle = @"1";
    [dataSource addObject:sectionObj];
    HFTableViewFormCellModel *cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"1";
    [sectionObj.cellModels addObject:cellModel];
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"2";
    [sectionObj.cellModels addObject:cellModel];
    //section 2
    sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 40;
    sectionObj.headTitle = @"2";
    [dataSource addObject:sectionObj];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"3";
    [sectionObj.cellModels addObject:cellModel];

    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"4";
    [sectionObj.cellModels addObject:cellModel];
   //section 3
    sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headTitle = @"3";
    sectionObj.headHeigth = 40;
    [dataSource addObject:sectionObj];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"5";
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"6";
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"7";
    [sectionObj.cellModels addObject:cellModel];
    
    [self.hft_tableView setCellModelsForModels:dataSource isAddmore:NO];
}


-(void)dealloc
{
    NSLog(@"dealloc");
}

@end
