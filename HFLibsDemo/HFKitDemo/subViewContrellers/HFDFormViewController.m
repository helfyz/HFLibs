//
//  HFDFormViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/6/27.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDFormViewController.h"
#import "UIViewController+HFTableViewManger.h"
#import <Masonry.h>
#import "HFTableViewManger+Form.h"
#import "HFButton.h"
#import "HFPickerView.h"
#import "NSString+HFRegex.h"
@interface HFDFormViewController ()

@end

@implementation HFDFormViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSStringFromClass([self class]);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
    [self setupData];
    self.hft_tableViewManger.scrollerToEndEdit = YES;
}

-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.hft_tableViewManger openKeyboardObserver];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.hft_tableViewManger closeKeyboardObserver];
    [super viewWillDisappear:animated];
}
-(void)setupTableView
{
    [self hft_setupGroupedTableViw];
    [self.hft_tableViewManger.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setupFooter];
}

-(void)setupData
{
    HFTableViewSectionModel *section1 = [[HFTableViewSectionModel alloc] init];
    section1.headTitle = @"基本信息";
    HFTableViewCellFormModel*cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDCustomInputTableViewCell"];
    cellModel.cellFormKey = @"name";
    cellModel.cellName = @"昵称";
    cellModel.cellData = @"您的昵称";
    cellModel.isRequired = YES;
    [section1 addCellModel:cellModel];
    cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDChooseTableViewCell"];
    cellModel.cellFormKey = @"sex";
    cellModel.cellName = @"性别";
    cellModel.cellData = @"您的性别";
    cellModel.isRequired = YES;
    cellModel.cellAction = @selector(chooseSex:);
    [section1 addCellModel:cellModel];
    
    HFTableViewSectionModel *section2 = [[HFTableViewSectionModel alloc] init];
    section2.headTitle = @"联系方式";
    cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDCustomInputTableViewCell"];
    cellModel.cellFormKey = @"phone";
    cellModel.cellName = @"电话号码";
    cellModel.cellRegex = [NSString hf_PhoneNumberRegex];
    cellModel.cellData = @"您的电话号码";
    [section2 addCellModel:cellModel];
    cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDCustomInputTableViewCell"];
    cellModel.cellFormKey = @"email";
    cellModel.cellName = @"邮箱";
    cellModel.cellData = @"您的邮箱地址";
    cellModel.cellRegex =  [NSString hf_EmailRegex];
    [section2 addCellModel:cellModel];
    
    HFTableViewSectionModel *section3 = [[HFTableViewSectionModel alloc] init];
    section3.headTitle = @"其它信息";
    cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDChooseTableViewCell"];
    cellModel.cellFormKey = @"city";
    cellModel.cellName = @"城市";
    cellModel.cellData = @"您所在的城市";
    cellModel.cellAction = @selector(chooseCity:);
    [section3 addCellModel:cellModel];
    cellModel = [HFTableViewCellFormModel cellModelForCellClassName:@"HFDCustomInputTableViewCell"];
    cellModel.cellFormKey = @"hobby";
    cellModel.cellName = @"爱好";
    cellModel.cellData = @"您的爱好";
    [section3 addCellModel:cellModel];
    
    [self.hft_tableViewManger setupDataSourceModels:@[section1,section2,section3] isAddmore:NO];
}
- (void)setupFooter {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 84)];
    HFButton *button = [[HFButton alloc] init];
    [button setTitile:@"确定" textColor:[UIColor whiteColor]];
    [button setNormalBgColor:[UIColor orangeColor] highlightedBgColor:[UIColor grayColor]];
    [button addTarget:self action:@selector(submit)];
    button.layer.cornerRadius = 5;
    [footer addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@(-10));
        make.height.equalTo(@44);
    }];
    self.hft_tableViewManger.tableView.tableFooterView = footer;
}
#pragma mark -- respone
-(void)submit
{
    [self.hft_tableViewManger formDataWithSuccess:^(NSDictionary *formData) {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"正确" message:[NSString stringWithFormat:@"%@",formData] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } fail:^(NSString *errorString) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:errorString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}

-(void)chooseSex:(HFTableViewCellFormModel *)cellModel
{
    [self.hft_tableViewManger scrollerToCellEditForCellModel:cellModel];
    HFPickerView *picker = [[HFPickerView alloc] initWithType:HFPickerViewTypeCustomData];
    picker.dataSourceArrry = @[@"男",@"女",@"保密"];
    picker.defaultValue =  cellModel.cellFormValue;
    [picker setChangeBlock:^(id value) {
        cellModel.cellFormValue = value;
        [self.hft_tableViewManger reloadCellForCellModel:cellModel withRowAnimation:UITableViewRowAnimationNone];
    }];
    [picker showInView:self.view];
}
-(void)chooseCity:(HFTableViewCellFormModel *)cellModel
{
    [self.hft_tableViewManger scrollerToCellEditForCellModel:cellModel];
    HFPickerView *picker = [[HFPickerView alloc] initWithType:HFPickerViewTypeCustomData];
    picker.dataSourceArrry = @[@"北京",@"上海",@"成都"];
    picker.defaultValue =  cellModel.cellFormValue;
    [picker setChangeBlock:^(id value) {
        cellModel.cellFormValue = value;
        [self.hft_tableViewManger reloadCellForCellModel:cellModel withRowAnimation:UITableViewRowAnimationNone];
    }];
    [picker showInView:self.view];
}
@end
