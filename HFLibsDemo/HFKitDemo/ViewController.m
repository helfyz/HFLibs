//
//  ViewController.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HFTableView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"HFTable";
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
    HFTableViewSectionModel *sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 30;
    sectionObj.headTitle = @"HFTable";
    HFTableViewFormCellModel *cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"HFDSettingViewController";
    cellModel.pushToClass = NSClassFromString(@"HFDSettingViewController");
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"HFDListViewController";
    cellModel.pushToClass = NSClassFromString(@"HFDListViewController");
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"HFDCommitViewController";
    cellModel.pushToClass = NSClassFromString(@"HFDCommitViewController");
    [sectionObj.cellModels addObject:cellModel];
    
    
    
    
    HFTableViewSectionModel *normalSectionObj = [[HFTableViewSectionModel alloc] init];
    normalSectionObj.headHeigth = 30;
    normalSectionObj.headTitle = @"常规方式";
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeNone];
    cellModel.title = @"HFDNormalSettingViewController";
    cellModel.pushToClass = NSClassFromString(@"HFDNormalSettingViewController");
    [normalSectionObj.cellModels addObject:cellModel];
    
    
    [self.hft_tableView setCellModelsForModels:@[sectionObj,normalSectionObj] isAddmore:NO];
    
}

@end
