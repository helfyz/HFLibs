//
//  HFDNormalViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/3/17.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDNormalSettingViewController.h"
#import <Masonry.h>
@interface HFDNormalSettingViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation HFDNormalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
-(void)setupTableView
{
    self.tableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    switch (count) {
        case 0:
            count = 2;
            break;
        case 1:
             count = 2;
            break;
        case 2:
            count = 3;
            break;
        default:
            break;
    }
    
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"1";
                }
                    break;
                case 1:
                {
                     cell.textLabel.text = @"2";
                }
                    break;
                default:
                    break;
            }
        
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"3";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"4";
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"5";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"6";
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"7";
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row ==0 && indexPath.section == 0)
    {
        return 50;
    }
    return 40;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * headerStr = @"";
    switch (section) {
        case 0:
            headerStr = @"1";
            break;
        case 1:
             headerStr = @"2";
            break;
        case 2:
            headerStr = @"3";
            break;
        default:
            break;
    }
    
    return headerStr;
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
@end
