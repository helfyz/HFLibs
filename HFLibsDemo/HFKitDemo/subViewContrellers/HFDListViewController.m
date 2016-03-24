//
//  HFDListViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/3/17.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDListViewController.h"
#import "UIViewController+HFTableView.h"
#import "HFDListTableViewCell.h"
#import "HFTableViewCustomCellModel.h"
@interface HFDListViewController ()

@end

@implementation HFDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupTableView
{
    [self hft_setupPlainTableViw];
}


-(void)setupData
{
    NSArray *textArray = @[@"HFLibs",
                           @"基于UIKit，希望能简化UIKit 的设置 快速开发",
                           @"tableView 是常规app中使用比较频繁的控件，但是我个人始终觉得tableView 的设置太过繁琐了。",
                           @"每次写个tableView，需要去实现一堆代理而且需求改动的话，修改也很跳跃，稍不注意就是坑。",
                           @"HFDNormalSettingViewController  采用原始的方式(switch) 来做的。 大家可以和 HFDSettingViewController 对比一下",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           @"哈哈哈",
                           ];
    
    NSArray *cellObjs = [self cellsForDataSource:textArray cellClassName:@"HFDListTableViewCell"];
    
    [self.hft_tableView setCellModelsForModels:cellObjs isAddmore:NO];
}
//批量设置数据cell
-(NSArray *)cellsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className
{
    [self.hft_tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
    
    NSMutableArray *subCellObjs = [NSMutableArray array];
    int index = 0;
    for (NSObject *obj in dataSource) {
        HFTableViewCustomCellModel *cellObj = [[HFTableViewCustomCellModel alloc] init];
        cellObj.valueData = obj;
        cellObj.useXib = YES;
        cellObj.tablViewCellClassName = className;
        if(index == 0)
        {
            cellObj.isStaticObj = YES;
            [cellObj setConfigCellBlock:^(HFTableViewCell *cell) {
                [((HFDListTableViewCell *)cell) contentLabel].textAlignment = NSTextAlignmentCenter;
            }];
        }
        [subCellObjs addObject:cellObj];
        index ++;
    }
    
    return subCellObjs;
}
//如果用户需要对cell进行配置
- (void)tableView:(UITableView *)sender configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    if([cell isKindOfClass:[HFDListTableViewCell class]])
    {
      //
    }
}

-(void)dealloc
{
    NSLog(@"dealloc");
}

@end
