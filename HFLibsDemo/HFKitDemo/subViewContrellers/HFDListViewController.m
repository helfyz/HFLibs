//
//  HFDListViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/6/27.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDListViewController.h"
#import "UIViewController+HFTableViewManger.h"
#import <Masonry.h>
@interface HFDListViewController ()

@end

@implementation HFDListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
    [self setupData];
}

-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}
-(void)setupTableView
{
    [self hft_setupGroupedTableViw];
    [self.hft_tableViewManger.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)setupData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int index = 0; index < 10; index ++) {
        [dataArray addObject:@(index).stringValue];
    }
    [self.hft_tableViewManger setupDataSourceModelsForData:dataArray cellClassName:@"HFDListTableViewCell" isAddmore:NO];
    //混点 UITableViewCell
    [dataArray removeAllObjects];
    for (int index = 0; index < 10; index ++) {
        HFTableViewCellModel*cellModel = [HFTableViewCellModel new];
        cellModel.cellHeigth = 44;
        [cellModel setConfigCellBlock:^(UITableViewCell *cell) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@-%i",[cell class],index];

        }];
        [dataArray addObject:cellModel];
    }
    [self.hft_tableViewManger setupDataSourceModels:dataArray isAddmore:YES];
}


//cell 设置了 响应block 和 action 将不再调用该方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}



@end
