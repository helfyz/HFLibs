//
//  HFDSettingViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/6/27.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDSettingViewController.h"
#import "UIViewController+HFTableViewManger.h"
#import <Masonry.h>
#import "HFTableViewManger+Form.h"
@interface HFDSettingViewController ()

@end

@implementation HFDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
    [self setupData];
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

    
}


//cell 设置了 响应block 和 action 将不再调用该方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}

@end
