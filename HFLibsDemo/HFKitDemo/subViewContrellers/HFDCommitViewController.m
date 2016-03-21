//
//  HFDCommitViewController.m
//  HFKitDemo
//
//  Created by helfy on 16/3/17.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFDCommitViewController.h"
#import "UIViewController+HFTableView.h"
#import "HFLibs.h"
#import <Masonry.h>
#import "HFDCustomInputTableViewCell.h"
@interface HFDCommitViewController ()
@property (nonatomic,strong) NSDate *birthdayDate;
@property (nonatomic,strong) NSString *customInputString;
@end

@implementation HFDCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    [self setupData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.hft_tableView openKeyboardObserver];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.hft_tableView closeKeyboardObserver];
}
    
-(void)setupTableView
{
    [self hft_setupGroupedTableViw];
    [self setupTableFooterView];
}
-(void)setupTableFooterView
{
    UIView *tableViewFooterView = [UIView new];
    tableViewFooterView.sizeHeight = 80;
    self.hft_tableView.tableFooterView = tableViewFooterView;
    
    HFButton *commitButton = [HFButton new];
    [commitButton setTitile:@"提交" textColor:[UIColor whiteColor]];
    [commitButton addTarget:self action:@selector(commit:)];
    [commitButton setNormalBgColor:[UIColor orangeColor] highlightedBgColor:[UIColor grayColor]];
    
    [tableViewFooterView addSubview:commitButton];
    commitButton.layer.cornerRadius=5;
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.height.equalTo(@(42));
        make.centerY.equalTo(tableViewFooterView);
    }];

}
-(void)setupData
{
    
    NSMutableArray *dataSource = [NSMutableArray array];
    //section 1
    HFTableViewSectionModel *sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 40;
    sectionObj.headTitle = @"信息1";
    [dataSource addObject:sectionObj];
    HFTableViewFormCellModel *cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeTextField];
    cellModel.title = @"用户名";
    cellModel.valuePlaceholder = @"在此输入您的用户名";
    cellModel.accessoryViewSize = CGSizeMake(220, 30);
    cellModel.modelKey = @"userName";
    cellModel.isRequired = YES;
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeTextView];
    cellModel.cellHeigth = 80;
    cellModel.title = @"签名";
    cellModel.accessoryViewSize = CGSizeMake(240, 80);
    cellModel.valuePlaceholder = @"在此输入您的签名";
    cellModel.modelKey = @"sign";
    
    [sectionObj.cellModels addObject:cellModel];
    //section 2
    sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 40;
    sectionObj.headTitle = @"信息2";
    [dataSource addObject:sectionObj];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeTextField];
    cellModel.title = @"手机号";
    [(UITextField *)cellModel.accessoryView setKeyboardType:UIKeyboardTypeNumberPad];
    cellModel.regex = @"^1\\d{10}";
    cellModel.isRequired = YES;
    cellModel.valuePlaceholder = @"请输入您的手机号";
    ((HFTextField *)cellModel.accessoryView).placeholderColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    cellModel.modelKey = @"phoneNumber";
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeTextField];
    cellModel.title = @"邮箱";
    cellModel.valuePlaceholder = @"请输入您的邮箱";
    [sectionObj.cellModels addObject:cellModel];
    //section 3
    sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headTitle = @"信息3";
    sectionObj.headHeigth = 40;
    [dataSource addObject:sectionObj];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeLabel];
    cellModel.title = @"性别";
    cellModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cellModel.modelKey = @"sex";
    cellModel.cellAction = @selector(chooseSex:);
    [sectionObj.cellModels addObject:cellModel];
    
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeLabel];
    cellModel.title = @"生日";
    cellModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cellModel.modelKey = @"birthday";
    cellModel.cellAction = @selector(chooseBirthday:);
    [sectionObj.cellModels addObject:cellModel];
    
    
    HFTableViewCustomCellModel *customCellModel = [[HFTableViewCustomCellModel alloc] init];
    customCellModel.useXib = YES;
    customCellModel.tablViewCellClassName = @"HFDCustomInputTableViewCell";
    customCellModel.modelKey = @"customInput";
    [customCellModel setConfigCellBlock:^(HFTableViewCell * cell) {
        HFDCustomInputTableViewCell *customCell = (HFDCustomInputTableViewCell *)cell;
        customCell.inputTextFiled.delegate = (id)self;
    }];
    [sectionObj.cellModels addObject:customCellModel];
    
    
    [self.hft_tableView setCellModelsForModels:dataSource isAddmore:NO];
}

#pragma mark --
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //如果未设置key。。 也可通过  textField.userInfo 来传递
    HFTableViewCustomCellModel *model = (HFTableViewCustomCellModel*)[self.hft_tableView cellModelForModelKey:@"customInput"];
    model.firstResponder = YES;
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
 
    self.customInputString = textField.text;
    HFTableViewCustomCellModel *model = (HFTableViewCustomCellModel*)[self.hft_tableView cellModelForModelKey:@"customInput"];
    model.firstResponder = NO;
    
    return YES;
}

#pragma mark -- cellAction
-(void)setBirthdayDate:(NSDate *)birthdayDate
{
    _birthdayDate = birthdayDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:_birthdayDate];
    
    HFTableViewFormCellModel *cellModel = [self.hft_tableView cellModelForModelKey:@"birthday"];
    cellModel.valueData = dateStr;
}

-(void)chooseSex:(HFTableViewFormCellModel *)cellModel
{
    [self.view endEditing:YES];
    
    HFPickerView *inputView = [[HFPickerView alloc] initWithType:HFPickerViewTypeCustomData];
    inputView.dataSourceArrry = @[@"男",@"女"];
    if([(NSString *)cellModel.valueData length]>0)
    {
        inputView.defaultValue = cellModel.valueData;
    }
    else{
        inputView.defaultValue = @"女";
    }
    [inputView showInView:self.view];
    [inputView setChangeBlock:^(id value) {
        cellModel.valueData = value;
    }];
}

-(void)chooseBirthday:(HFTableViewFormCellModel *)cellModel
{
    [self.view endEditing:YES];
    
    HFPickerView *inputView = [[HFPickerView alloc] initWithType:HFPickerViewTypeDate];
    
    if(self.birthdayDate)
    {
        inputView.defaultValue = self.birthdayDate;
    }
    else{
        inputView.defaultValue = [NSDate date];
    }
    
    [inputView showInView:self.view];
    [inputView setChangeBlock:^(id value) {
        self.birthdayDate = value;
    }];
}

-(void)commit:(HFButton *)button
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (HFTableViewSectionModel *sectionModel in self.hft_tableView.dataSourceModels) {
        for (HFTableViewFormCellModel *cellModel in sectionModel.cellModels) {
            if(![cellModel isKindOfClass:[HFTableViewFormCellModel class]])
            {
                continue;
            }
            NSString *error = [cellModel checkValueError];
            if(error)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"填写错误" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
            else {
                if(cellModel.valueData && cellModel.modelKey)
                {
                    [dic setObject:cellModel.valueData forKey:cellModel.modelKey];
                }
            }
        }
    }
    //
    if(self.customInputString)
    {
        [dic setObject:self.customInputString forKey:@"customInput"];
        
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"填写完成" message:[NSString stringWithFormat:@"%@",dic] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
@end
